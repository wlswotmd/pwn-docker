FROM ubuntu:22.04
WORKDIR /root
ENV LC_CTYPE C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive

# install dependencies & tools
RUN dpkg --add-architecture i386
RUN apt update -y
RUN apt install python3 python3-pip python3-dev python3-setuptools \
    libssl-dev libffi-dev build-essential libc6-i386 libc6-dbg gcc-multilib \
    make gcc netcat git file curl wget gdb vim nano zsh ruby-full net-tools socat tmux cargo -y
RUN curl https://bootstrap.pypa.io/get-pip.py | python3
RUN python3 -m pip install --upgrade pip
RUN pip3 install pwntools
RUN gem install one_gadget seccomp-tools
RUN cargo install ropr

# install gef & customize
RUN bash -c "$(curl -fsSL https://gef.blah.cat/sh)"
RUN git clone https://github.com/scwuaptx/Pwngdb.git .pwngdb
RUN echo -n "source ~/.pwngdb/pwngdb.py\\nsource ~/.pwngdb/angelheap/gdbinit.py\\n\\ndefine hook-run\\npython\\nimport angelheap\\nangelheap.init_angelheap()\\nend\\nend" >> ~/.gdbinit
RUN gdb -ex 'gef save' -ex quit
RUN sed "/\[aliases\]$/a\pd = disassemble" ~/.gef.rc > ~/.gef.rc
RUN sed 's/^layout.*/layout = -legend regs code args source stack memory -threads -trace extra/g' ~/.gef.rc > ~/.gef.rc

# install zsh & customize
RUN mkdir .zsh
RUN git clone https://github.com/sindresorhus/pure .zsh/pure
RUN git clone https://github.com/zdharma-continuum/fast-syntax-highlighting .zsh/fast-syntax-highlighting
RUN echo "ZSH_THEME=""\\nsource /root/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh\\nfpath+=/root/.zsh/pure\\nautoload -U promptinit; promptinit\\nprompt pure\\nPATH=$PATH:~/.cargo/bin" > .zshrc

# make a working directory
RUN mkdir /root/pwn
WORKDIR /root/pwn
