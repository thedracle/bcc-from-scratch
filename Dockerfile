FROM alpine:3.9.4
RUN apk add --update \
  bash \
  bison \
  binutils \
  build-base \
  clang-dev \
  clang-static \
  curl \
  cmake \
  elfutils-dev \
  flex-dev \
  git \
  perl \
  linux-headers \
  llvm5-dev \
  llvm5-static \
  python \
  py-pip \
  iperf \
  zlib-dev

# Prepare LLVM for cmake.
RUN ln -s /usr/lib/cmake/llvm5 /usr/lib/cmake/llvm
RUN ln -s /usr/include/llvm5/llvm /usr/include/llvm
RUN ln -s /usr/include/llvm5/llvm-c /usr/include/llvm-c

RUN pip install conan
RUN mkdir -p /opt/thedracle/ebpfdemo/
COPY . /opt/thedracle/ebpfdemo
WORKDIR /opt/thedracle

# Build BCC, copy in dependencies, and build demo project.
RUN git clone https://github.com/iovisor/bcc.git;cd bcc;git checkout d8176d2df9951975a1fd47bbf021daf3f435c70c

RUN cd bcc && mkdir build && cd build && cmake .. && cd .. && cp /opt/thedracle/ebpfdemo/patches/bcc.patch . && patch -p0 < bcc.patch && cd /opt/thedracle/bcc/build && make
RUN cd ebpfdemo && ./bin/copy_bcc.sh && make
