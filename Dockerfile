FROM ubuntu:22.04

# 防止 apt 失败，加上partial目录创建
RUN mkdir -p /var/lib/apt/lists/partial \
 && apt-get update && apt-get install -y \
    build-essential cmake git cppcheck \
    libgtest-dev && \
    cd /usr/src/gtest && makedir build && cd build && \
    cmake .. && make -j$(nproc) && cp *.a /usr/lib && \
    apt-get clean

COPY . /app
WORKDIR /app/build

RUN cmake .. && make && ctest
CMD ["./app"]