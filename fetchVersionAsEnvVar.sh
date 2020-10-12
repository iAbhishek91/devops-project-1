#!/bin/bash


# fetch the version from package.json
export VERSION=$(cat package.json | grep version | awk -F: '{ print $2 }' | sed 's/[",]//g')

echo "::set-env name=VERSION::$VERSION"