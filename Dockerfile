FROM rust:1.97.1-trixie

RUN sed -i -e's/ main/ main contrib/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && \
    apt-get install -y libssl-dev build-essential pkg-config autoconf libtool \
        libudev-dev zlib1g zlib1g-dev libtirpc3 libtirpc-dev \
        libzfslinux-dev golang clang-19 libvirt-dev \
        mtools zstd \
        && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://capnproto.org/capnproto-c++-1.4.0.tar.gz && \
    echo "fa02378ad522b318916b9ad928d1372fc9abd43dd1f4f0392e50450f5c87828f  capnproto-c++-1.4.0.tar.gz" | sha256sum -c

RUN tar zxvf capnproto-c++-1.4.0.tar.gz && \
    cd capnproto-c++-1.4.0 && \
    ./configure && \
    make -j8 check && \
    make install && \
    cd .. && \
    rm -rf capnproto-c++-1.4.0

RUN git clone https://github.com/capnproto/capnproto-java.git && \
    cd capnproto-java && \
    git checkout d1c239e5af24bb28e2e41b5ee77107e3317e4621 && \
    make && \
    make install && \
    cd .. && \
    rm -rf capnproto-java

RUN rustup component add rustfmt
RUN rustup component add clippy

