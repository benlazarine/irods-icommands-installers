#!/bin/bash

readonly OS="$1"

mkdir --parents /packages/"$OS"

case "$OS"
in
  ubuntu-12)
    readonly LibDir=/lib
    ;;
  ubuntu-14)
    readonly LibDir=/lib/x86_64-linux-gnu
    ;;
  *)
    readonly LibDir=/lib64
    ;;
esac

readonly Scripts=$(dirname "$0")

for ver in 4.1.9 4.1.9-cv
do
  src=/src/"$ver"
  pkg="$src"/packaging

  rm --force "$src"/icommands.tgz
  "$pkg"/build.sh clean

  if ! "$pkg"/build.sh -r icommands; then continue; fi

  if [ "$ver" == 4.1.9-cv ]
  then
    artifact=$(cd "$src"/build && ls)

    if [ "$OS" == ubuntu-12 -o "$OS" == ubuntu-14 ]
    then
      cvArtifact="${artifact/64bit.deb/cv-64bit-$OS.deb}"
    else
      cvArtifact="${artifact/64bit/cv-64bit}"
    fi

    cp "$src"/build/"$artifact" /packages/"$OS"/"$cvArtifact"
  fi

  if [ "$ver" == 4.1.9 ]
  then
    if (cd "$src" && "$pkg"/make_icommands_for_distribution.sh)
    then
      "$Scripts"/installer-gen/gen-installer \
          /packages/"$OS"/irods-icommands-"$ver"-"$OS".installer \
          "$src"/icommands.tgz \
          "$Scripts"/config-icommands.sh

      rm --force "$src"/icommands.tgz
    fi
  fi

  fuse="$src"/irods-fuse
  tgz="$fuse".tgz
  mkdir --parents "$fuse"/bin "$fuse"/lib
  cp "$src"/iRODS/clients/fuse/bin/irodsFs "$fuse"/bin
  cp "$LibDir"/libfuse.so.2 "$fuse"/lib
  tar --create --gzip --directory "$src" --file "$tgz" irods-fuse

  "$Scripts"/installer-gen/gen-installer \
      /packages/"$OS"/irods-fuse-"$ver"-"$OS".installer \
      "$tgz" \
      "$Scripts"/config-fuse.sh

  rm --force --recursive "$fuse" "$tgz"
  "$pkg"/build.sh clean
done
