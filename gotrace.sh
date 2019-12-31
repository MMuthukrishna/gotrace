#!/bin/bash

IMAGETAG="mmuthukrishna/golang:gotrace1.8"

if [ $# -eq 0 ]; then
    echo -e "Usage: Require go file pathname(some code enable trace goroutines)\n\
    Shell : sh gotrace.sh goroutines.go"
    exit;
fi

exist=$(docker images|grep gotrace1.8|wc -l)
if [ $exist -eq 0 ]; then
    echo "build image $IMAGETAG"
    {
        workspace=$(cd $(dirname $0) && pwd -P)
        docker build . -t  $IMAGETAG
    }
fi

docker run --rm -it  -p 2000:2000  -v $PWD:/go $IMAGETAG $1
