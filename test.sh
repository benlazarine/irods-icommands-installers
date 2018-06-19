#! /bin/bash

readonly Ver=4.1.10


declare -A Images=(
  [centos-6]=centos:6
  [centos-7]=centos:7
  [ubuntu-12]=ubuntu:precise
  [ubuntu-14]=ubuntu:trusty
)


main()
{
  local iesHost
  local iesPort
  local user
  local zone
  local password

  read -p 'Enter the host name (DNS) of the server to connect to: ' iesHost
  read -p 'Enter the port number: ' iesPort
  read -p 'Enter your irods user name: ' user
  read -p 'Enter your irods zone: ' zone
  read -s -p 'Enter your current iRODS password: ' password
  printf '\n'

  local allPass=true

  for os in "${!Images[@]}"
  do
    printf '>>> Testing %s on %s\n' "$Ver" "$os"

    docker run --interactive --privileged --rm --volume "$PWD"/packages:/packages \
        "${Images[$os]}" bash \
      < <(mk_test_script "$os" "$iesHost" "$iesPort" "$user" "$zone" "$password") \
      > /dev/null

    if [ "$?" -eq 0 ]
    then
      printf '<<< %s on %s passed\n' "$Ver" "$os"
    else
      allPass=false
      printf '<<< %s on %s failed\n' "$Ver" "$os"
    fi
  done

  if [ "$allPass" = false ]
  then
    return 1
  fi
}


mk_test_script()
{
  local os="$1"
  local iesHost="$2"
  local iesPort="$3"
  local user="$4"
  local zone="$5"
  local password="$6"

  cat \
<<EOF
export IRODS_HOST="$iesHost"
export IRODS_PORT="$iesPort"
export IRODS_USER_NAME="$user"
export IRODS_ZONE_NAME="$zone"

if ! bash /packages/"$os"/irods-icommands-"$Ver"-"$os".installer /root
then
  printf 'iCommands installation failed\n' >&2
  exit 1
fi

if ! bash /packages/"$os"/irods-fuse-"$Ver"-"$os".installer /root
then
  printf 'iRODS FUSE installation failed\n' >&2
  exit 1
fi

sed --in-place '/[ -z "\$PS1" ] && return/d' /root/.bashrc
. /root/.bashrc

if ! iinit "$password"
then
  printf 'iinit failed\n' >&2
  exit 1
fi

if ! iput -f /root/.bashrc bashrc
then
  printf 'iput failed\n' >&2
  exit 1
fi

mkdir /tmp/fmount

if ! irodsFs /tmp/fmount
then
  printf 'irodsFs failed to mount\n' >&2
  exit 1
fi

ls /tmp/fmount | grep --quiet --regexp '^bashrc\$'
EOF
}


main
