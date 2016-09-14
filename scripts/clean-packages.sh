#!/bin/bash

readonly OS="$1"

rm --force --recursive /packages/"$OS"

/src/packaging/build.sh clean
