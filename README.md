# pwn-docker
A docker environment for pwnable challenges

## TODO
- [ ] fix to run "challenge" using given ld file
- [ ] add dependency option

## Usage

1. build docker images to use

    ```bash
    # example
    ~/pwn-docker> ./build.sh -v 20.04
    ```

2. Copy the problem file and libc, ld, etc to use under the directory you want to share with the docker image

3. run docker image
    ```bash
    # example
    ~/prob_dir> ls
    ld-linux-x86-64.so.2  libc-2.31.so  chal

    ~/prob_dir> ~/pwn-docker/run.sh -v 20.04 -l libc-2.31.so -d ld-linux-x86-64.so.2 -c chal
    ```

4. connect to prob via nc, pwntools, etc.
    ```bash
    ~/prob_dir> nc localhost 12345 
    ```

5. attach to prob via gdb
    ```bash
    # example
    ~/prob_dir> sudo gdb chal -q
    gef> at
    gef> vmmap
    [ Legend:  Code | Heap | Stack | Writable | ReadOnly | None | RWX ]
    Start              End                Size               Offset             Perm Path
    0x0000555555554000 0x0000555555555000 0x0000000000001000 0x0000000000000000 r-- /root/pwn/prob
    0x0000555555555000 0x0000555555556000 0x0000000000001000 0x0000000000001000 r-x /root/pwn/prob
    0x0000555555556000 0x0000555555557000 0x0000000000001000 0x0000000000002000 r-- /root/pwn/prob  <-  $r10
    0x0000555555557000 0x0000555555558000 0x0000000000001000 0x0000000000002000 r-- /root/pwn/prob
    0x0000555555558000 0x0000555555559000 0x0000000000001000 0x0000000000003000 rw- /root/pwn/prob
    0x00007ffff7dd5000 0x00007ffff7dfa000 0x0000000000025000 0x0000000000000000 r-- /root/pwn/libc-2.31.so
    0x00007ffff7dfa000 0x00007ffff7f72000 0x0000000000178000 0x0000000000025000 r-x /root/pwn/libc-2.31.so  <-  $rcx, $rip
    0x00007ffff7f72000 0x00007ffff7fbc000 0x000000000004a000 0x000000000019d000 r-- /root/pwn/libc-2.31.so
    0x00007ffff7fbc000 0x00007ffff7fbd000 0x0000000000001000 0x00000000001e7000 --- /root/pwn/libc-2.31.so
    0x00007ffff7fbd000 0x00007ffff7fc0000 0x0000000000003000 0x00000000001e7000 r-- /root/pwn/libc-2.31.so
    0x00007ffff7fc0000 0x00007ffff7fc3000 0x0000000000003000 0x00000000001ea000 rw- /root/pwn/libc-2.31.so  <-  $rbx, $rbp, $rsi, $r12, $r13, $r15
    0x00007ffff7fc3000 0x00007ffff7fc9000 0x0000000000006000 0x0000000000000000 rw- <tls-th1>
    0x00007ffff7fc9000 0x00007ffff7fcd000 0x0000000000004000 0x0000000000000000 r-- [vvar]
    0x00007ffff7fcd000 0x00007ffff7fcf000 0x0000000000002000 0x0000000000000000 r-x [vdso]
    0x00007ffff7fcf000 0x00007ffff7fd0000 0x0000000000001000 0x0000000000000000 r-- /usr/lib/x86_64-linux-gnu/ld-2.31.so
    0x00007ffff7fd0000 0x00007ffff7ff3000 0x0000000000023000 0x0000000000001000 r-x /usr/lib/x86_64-linux-gnu/ld-2.31.so
    0x00007ffff7ff3000 0x00007ffff7ffb000 0x0000000000008000 0x0000000000024000 r-- /usr/lib/x86_64-linux-gnu/ld-2.31.so
    0x00007ffff7ffc000 0x00007ffff7ffd000 0x0000000000001000 0x000000000002c000 r-- /usr/lib/x86_64-linux-gnu/ld-2.31.so
    0x00007ffff7ffd000 0x00007ffff7ffe000 0x0000000000001000 0x000000000002d000 rw- /usr/lib/x86_64-linux-gnu/ld-2.31.so
    0x00007ffff7ffe000 0x00007ffff7fff000 0x0000000000001000 0x0000000000000000 rw-
    0x00007ffffffde000 0x00007ffffffff000 0x0000000000021000 0x0000000000000000 rw- [stack]  <-  $rsp
    ```