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

# apt install
RUN add-apt-repository ppa:apt-fast/stable \
    && apt-get update \
    && apt-get -y install apt-fast \
    && dpkg --add-architecture i386 \
    && apt-fast install -y build-essential \
    && apt-fast install -y \
    binutils-multiarch \
    binwalk \
    coreutils \
    curl \
    foremost \
    g++-multilib \
    gcc-multilib \
    gdb \
    git \
    graphviz-dev \
    hydra \
    libc6-i386 \
    libc6-dev-i386 \
    libssl-dev \
    libssl-dev:i386 \
    libgmp-dev \
    libevent-dev \
    libffi-dev \
    libpcap-dev \
    libpcre++-dev \
    libtool-bin \
    llvm \
    ltrace \
    nasm \
    netcat \
    nmap \
    ncurses-dev \
    pcregrep \
    php-cli \
    python-pip \
    python2.7 \
    python2.7-dev \
    python3-dev \
    python3-pip \
    p7zip \
    qemu \
    radare2 \
    socat \
    strace \
    sudo \
    tcpdump \
    vim \
    volatility \
    wget \
    zip \
    && apt-fast clean \

# pip install
    && pip install \
    angr \
    distorm3 \
    gmpy \
    hashid \
    pwn \
    scapy \
    yara-python \
    && pip3 install \
    hashid \
    pycparser \
    scapy \ 
    && rm -rf /tmp/* \

# non package tools install
    && mkdir -p ~/tools \

# rp ++
    && cd ~/tools \
    && git clone https://github.com/0vercl0k/rp.git \
    && cd rp \
    && git checkout next \
    && git submodule update --init --recursive \
    && sed -i 's/find_package(Boost 1.59.0 COMPONENTS flyweight)/find_package(Boost)/g' CMakeLists.txt \
    && mkdir build \
    && cd build \
    && cmake ../ \
    && make \
    && cp ../bin/rp-lin-x64 /usr/local/bin/ \

# peda
    && git clone https://github.com/longld/peda.git ~/tools/peda \
    && echo -en "source ~/tools/peda/peda.py\n" >> ~/.gdbinit \

# pwngdb
    && git clone https://github.com/scwuaptx/Pwngdb.git ~/tools/pwngdb \
    && echo -en "sorce ~/tools/pwngdb/pwngdb.py\n" >> ~/.gdbinit \
    && echo -en "sorce ~/tools/pwngdb/ngelheap/gdbinit.py\n" >> ~/.gdbinit \

# qira
    && git clone https://github.com/geohot/qira.git ~/tools/qira \
    && cd ~/tools/qira \
    && ./install.sh \
    && ./fetchlibs.sh \

# capstone
    && git clone https://github.com/aquynh/capstone ~/tools/capstone \
    && cd ~/tools/capstone \
    && ./make.sh \
    && ./make.sh install \
    && cd ~/tools/capstone/bindings/python \
    && python3 setup.py install \
    && python2 setup.py install \

# keystone
    && git clone https://github.com/keystone-engine/keystone.git ~/tools/keystone \
    && cd ~/tools/keystone \
    && mkdir build \
    && cd build \
    && ../make-share.sh \
    && make install \
    && ldconfig \
    && cd ~/tools/keystone/bindings/python \
    && make install \

# ROPGadget
    && git clone https://github.com/JonathanSalwan/ROPgadget ~/tools/ROPgadget \
    && cd ~/tools/ROPgadget \
    && python setup.py install \

# Z3 Prover
		&& git clone https://github.com/Z3Prover/z3.git ~/tools/z3 \
    && cd ~/tools/z3 \
    && python scripts/mk_make.py --python \
    && cd build \
    && make install \

# afl
    && wget --quiet http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz -O ~/tools/afl-latest.tgz \
    && cd ~/tools \
    && tar xvf afl-latest.tgz \
    && cd afl-* && make \
    && cd qemu_mode && ./build_qemu_support.sh \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# dotfiles
RUN touch ~/.bash_history \
    && git clone https://github.com/takuzoo3868/dotfiles.git ~/.dotfiles \
    && cd ~/.dotfiles \
    && chmod +x setup_link.sh && ./setup_link.sh

# init startup script
RUN mkdir -p /etc/my_init.d
COPY bin/banner.py /etc/my_init.d/banner.py
RUN chmod +x /etc/my_init.d/banner.py

EXPOSE 22 1337 3002 3003 4000
CMD ["/bin/bash"]
