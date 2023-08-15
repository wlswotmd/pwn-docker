#!/bin/sh

if [ $CUSTOM_LD != "" ]
then
    exec="/root/pwn/$CUSTOM_LD /root/pwn/$CHALLENGE"
else
    exec="/root/pwn/$CHALLENGE"
fi

LD_PRELOAD=/root/pwn/$CUSTOM_LIBC /bin/socat -T 60 TCP-LISTEN:12345,reuseaddr,fork EXEC:"$exec",stderr