#!/bin/bash

readonly OS="$1"
readonly Ver=4.1.10

rm --force --recursive /packages/"$OS"
/src/"$Ver"/packaging/build.sh clean
rm --force /src/"$Ver"/icommands.tgz
