FROM rust:1.92.0-trixie

RUN sed -i -e's/ main/ main contrib/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && \
    apt-get install -y libssl-dev build-essential pkg-config autoconf libtool \
        libudev-dev zlib1g zlib1g-dev libtirpc3 libtirpc-dev \
        libzfslinux-dev golang clang-19 libvirt-dev && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://capnproto.org/capnproto-c++-1.2.0.tar.gz && \
    echo "ed00e44ecbbda5186bc78a41ba64a8dc4a861b5f8d4e822959b0144ae6fd42ef  capnproto-c++-1.2.0.tar.gz" | sha256sum -c

RUN tar zxvf capnproto-c++-1.2.0.tar.gz && \
    cd capnproto-c++-1.2.0 && \
    ./configure && \
    make -j8 check && \
    make install && \
    cd .. && \
    rm -rf capnproto-c++-1.2.0

RUN git clone https://github.com/capnproto/capnproto-java.git && \
    cd capnproto-java && \
    git checkout d1c239e5af24bb28e2e41b5ee77107e3317e4621 && \
    make && \
    make install && \
    cd .. && \
    rm -rf capnproto-java

RUN rustup component add rustfmt
RUN rustup component add clippy

