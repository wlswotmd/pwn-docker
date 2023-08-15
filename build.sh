#!/bin/sh

print_usage () {
    echo "Usage: $0 [Options]..."
    echo "    -h    display this help and exit"
    echo "    -v    ubuntu version to build (default: 22.04; 16.04, 18.04, 20.04, 22.04, 23.04 are available)"
}

set -- $(getopt hv: "$@")

# default options
version="22.04"

# parse options
while [ -n "$1" ]
do 
    case "$1" in
        -h) print_usage
            exit 0;;
        -v) version=$2
            shift;;
        --) break;;
        *)
            echo "Unknown option $1"
            print_usage
            exit 1;;
    esac
    shift
done

sudo docker build --no-cache -t $version:latest -f ./Dockerfiles/$version/Dockerfile .