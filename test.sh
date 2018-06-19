#! /bin/bash

readonly Ver=4.1.9

read -p 'Enter the host name (DNS) of the server to connect to: ' iesHost
read -p 'Enter the port number: ' iesPort
read -p 'Enter your irods user name: ' user
read -p 'Enter your irods zone: ' zone
read -s -p 'Enter your current iRODS password: ' password
printf '\n'

declare -A images=(
  [centos-6]=centos:6
  [centos-7]=centos:7
  [ubuntu-12]=ubuntu:precise
  [ubuntu-14]=ubuntu:trusty
)

allPass=true

for os in "${!images[@]}"
do
  printf '>>> Testing %s on %s\n' "$Ver" "$os"

  docker run --interactive --privileged --rm --volume "$PWD"/packages:/packages \
      "${images[$os]}" bash \
    > /dev/null \
<<EOF
if ! bash /packages/"$os"/irods-icommands-4.1.9-"$os".installer /root
then
  exit 1
fi

if ! bash /packages/"$os"/irods-fuse-"$Ver"-"$os".installer /root
then
  exit 1
fi

sed --in-place '/[ -z "\$PS1" ] && return/d' /root/.bashrc
. /root/.bashrc

printf '%s\n%s\n%s\n%s\n' "$iesHost" "$iesPort" "$user" "$zone" | iinit "$password"

if [ "$?" -ne 0 ]
then
  exit 1
fi

if ! iput -f /root/.bashrc bashrc
then
  exit 1
fi

mkdir /tmp/fmount

if ! irodsFs /tmp/fmount
then
  exit 1
fi

ls /tmp/fmount | grep --quiet --regexp '^bashrc\$'
EOF

  if [ "$?" -eq 0 ]
  then
    printf '<<< %s on %s passed\n' "$Ver" "$os"
  else
    allPass=false
    printf '<<< %s on %s failed\n' "$Ver" "$os"
  fi
done

if [ "$allPass" == false ]
then
  exit 1
fi
