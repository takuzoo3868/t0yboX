FROM phusion/baseimage:latest
LABEL maintainer="tăküz00"

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="MIT" \
    org.label-schema.name="takuzoo3868/t0yboX" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/takuzoo3868/t0yboX"

WORKDIR /root

# apt-get install
RUN add-apt-repository ppa:apt-fast/stable && apt-get update && apt-get -y install apt-fast

RUN dpkg --add-architecture i386 && apt-fast update \
    && apt-fast install -y build-essential \
    && apt-fast install -y gcc-multilib g++-multilib coreutils binutils-multiarch gdb git vim python python3 python-pip python3-pip \
    socat netcat nmap tcpdump curl wget llvm php-cli nasm qemu radare2 ltrace strace foremost volatility binwalk zip screenfetch \
    && apt-fast clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# pip install
RUN pip install hashid scapy pwn && \
    pip3 install hashid scapy 

# rp ++
RUN wget https://github.com/0vercl0k/rp/releases/download/v1/rp-lin-x64 \
    && wget https://github.com/0vercl0k/rp/releases/download/v1/rp-lin-x86 \
    && chmod +x rp-lin-x64 rp-lin-x86 \
    && mv rp-lin-x64 rp-lin-x86 /usr/local/bin

# peda
RUN apt-fast install -y nasm \
    && git clone https://github.com/longld/peda.git ~/.peda \
    && echo "source ~/.peda/peda.py" >> ~/.gdbinit \
    && echo "DONE! debug your program with gdb and enjoy"

# pwngdb
RUN git clone https://github.com/scwuaptx/Pwngdb.git ~/.pwngdb \
    && echo "sorce ~/.pwngdb/pwngdb.py" >> ~/.gdbinit \
    && echo "sorce ~/.pwngdb/ngelheap/gdbinit.py" >> ~/.gdbinit 

# angr, z3py
RUN apt-fast install -y python-dev libffi-dev python-pip \
    && apt-get clean \
    && pip install angr

# qira
RUN git clone https://github.com/geohot/qira.git ~/.qira \
    && cd ~/.qira \
    && ./install.sh \
    && ./fetchlibs.sh \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# afl
RUN apt-fast install -y libtool-bin \
    && apt-fast clean \
    && wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz \
    && tar xvf afl-latest.tgz \
    && cd afl-* && make \
    && cd qemu_mode && ./build_qemu_support.sh

# dotfiles
RUN touch ~/.bash_history \
    && git clone https://github.com/takuzoo3868/dotfiles.git ~/.dotfiles \
    && cd ~/.dotfiles \
    && chmod +x setup_link.sh && ./setup_link.sh

# init startup script
RUN mkdir -p /etc/my_init.d
COPY bin/banner.py /etc/my_init.d/banner.py
RUN chmod +x /etc/my_init.d/banner.py

# qira port
EXPOSE 80 3002 3003 4000

CMD ["/bin/bash"]
