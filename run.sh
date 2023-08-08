#!/bin/sh

print_usage () {
    echo "Usage: $0 [Options]..."
    echo "    -h    display this help and exit"
    echo "    -v    ubuntu version to use (default: 22.04; 16.04, 18.04, 20.04, 22.04, 23.04 are available)"
    echo "    -l    custom libc name"
    echo "    -d    custom ld name"
    echo "    -p    custom port (default: 12345)"
    echo "    -n    container name (default: random name)"
    echo "    -s    shared directory path (default: \$PWD)"
    echo "    -c    challenge name (default: prob)"
}

set -- $(getopt hv:l:d:p:n:s:c: "$@")

# default options
libc=""
ld=""
port="12345"
version="22.04"
name=`dd bs=18 count=1 if=/dev/urandom 2>/dev/null | base64 | tr +/ __`
shared_dir=$PWD
chal="prob"

# parse options
while [ -n "$1" ]
do 
    case "$1" in
        -h) print_usage
            exit 0;;
        -v) version=$2
            shift;;
        -l) libc=$2
            shift;;
        -d) ld=$2
            shift;;
        -p) port=$2
            shift;;
        -n) name=$2
            shift;;
        -s) shared_dir=$2
            shift;;
        -c) chal=$2
            shift;;
        --) shift
            break;;
        *)
            echo "Unknown option $1"
            print_usage
            exit 1;;
    esac
    shift
done

sudo docker run -d --rm -v "$shared_dir":/root/pwn \
    -e "CUSTOM_LIBC=$libc" -e "CUSTOM_LD=$ld" -e "CHALLENGE=$chal" \
    -p $port:1337 --name $name $version /root/start_chal.sh