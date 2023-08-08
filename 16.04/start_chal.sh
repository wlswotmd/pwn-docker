#!/bin/sh

if [ $CUSTOM_LD != "" ]
then
    LD_PRELOAD=/root/pwn/$CUSTOM_LIBC /root/pwn/$CUSTOM_LD /bin/socat -T 60 TCP-LISTEN:1337,reuseaddr,fork EXEC:/root/pwn/$CHALLENGE,stderr
else
    LD_PRELOAD=/root/pwn/$CUSTOM_LIBC /bin/socat -T 60 TCP-LISTEN:1337,reuseaddr,fork EXEC:/root/pwn/$CHALLENGE,stderr
fi