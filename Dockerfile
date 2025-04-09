FROM rust:1.86.0-bullseye

RUN curl -O https://capnproto.org/capnproto-c++-0.10.4.tar.gz && \
    echo "981e7ef6dbe3ac745907e55a78870fbb491c5d23abd4ebc04e20ec235af4458c  capnproto-c++-0.10.4.tar.gz" | sha256sum -c

RUN tar zxvf capnproto-c++-0.10.4.tar.gz && \
    cd capnproto-c++-0.10.4 && \
    ./configure && \
    make -j8 check && \
    make install && \
    cd .. && \
    rm -rf capnproto-c++-0.10.4

RUN git clone https://github.com/capnproto/capnproto-java.git && \
    cd capnproto-java && \
    git checkout 0fd8452dab167618e5074dfa900afdec7553f400 && \
    make && \
    make install && \
    cd .. && \
    rm -rf capnproto-java

RUN rustup component add rustfmt


