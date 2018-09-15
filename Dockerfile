FROM ubuntu:16.04

# apt-get install
RUN apt update && apt -y upgrade && apt install -y \
    build-essential gcc-multilib g++-multilib coreutils binutils-multiarch gdb git vim python python3 python-pip python3-pip ipython ipython3 \
    socat netcat nmap tcpdump curl wget llvm php-cli nasm qemu radare2 ltrace strace foremost volatility binwalk zip screenfetch

# pip install
RUN pip install hashid scapy pwn && \
    pip3 install hashid scapy 

# rp ++
RUN wget https://github.com/0vercl0k/rp/releases/download/v1/rp-lin-x64 \
    && wget https://github.com/0vercl0k/rp/releases/download/v1/rp-lin-x86 \
    && chmod +x rp-lin-x64 rp-lin-x86 \
    && mv rp-lin-x64 rp-lin-x86 /usr/local/bin

# peda
RUN apt install -y nasm \
    && git clone https://github.com/longld/peda.git ~/peda \
    && echo "source ~/peda/peda.py" >> ~/.gdbinit

# angr, z3py
RUN apt install -y python-dev libffi-dev python-pip \
    && apt-get clean \
    && pip install angr

# pin
RUN wget http://software.intel.com/sites/landingpage/pintool/downloads/pin-3.0-76991-gcc-linux.tar.gz \
    && tar xvf pin-3.0-76991-gcc-linux.tar.gz

# qira
RUN apt-get install -y sudo \
    && apt-get clean \
    && wget -qO- https://github.com/BinaryAnalysisPlatform/qira/archive/v1.2.tar.gz | tar zx && cd qira-1.2 && ./install.sh

# afl
RUN apt-get install -y libtool-bin \
    && apt-get clean \
    && wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz \
    && tar xvf afl-latest.tgz \
    && cd afl-* && make \
    && cd qemu_mode && ./build_qemu_support.sh

# Hello t0yboX!!!
CMD ["screenfetch"]