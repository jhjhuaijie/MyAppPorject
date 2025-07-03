FROM ubuntu:22.04

# 防止 apt 失败，加上partial目录创建
RUN mkdir -p /var/lib/apt/lists/partial \
 && apt-get update \
 && apt-get install -y g++ cmake make git curl

COPY . /app
WORKDIR /app/build

RUN cmake .. && make && ctest
CMD ["./app"]