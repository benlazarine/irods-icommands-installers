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

/src/packaging/build.sh clean
/src/packaging/build.sh -r icommands
/src/packaging/make_icommands_for_distribution.sh
"$(dirname $0)"/gen-installer /packages/"$OS"/irods-icommands-4.1.9-"$OS".installer \
                              /src/icommands.tgz \
                              "$(dirname $0)"/config-icommands.sh

mkdir --parents /src/irods-fuse/bin /src/irods-fuse/lib
cp /src/iRODS/clients/fuse/bin/irodsFs /src/irods-fuse/bin
cp "$LibDir"/libfuse.so.2 /src/irods-fuse/lib
tar --create --gzip --directory /src --file /src/irods-fuse.tgz irods-fuse
"$(dirname $0)"/gen-installer /packages/"$OS"/irods-fuse-4.1.9-"$OS".installer \
                              /src/irods-fuse.tgz \
                              $(dirname "$0")/config-fuse.sh
rm --force --recursive /src/irods-fuse /src/irods-fuse.tgz
