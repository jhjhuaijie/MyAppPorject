FROM ubuntu:22.04

RUN apt-get update && apt-get install -y cmake g++ git

COPY . /app
WORKDIR /app/build

RUN cmake .. && make && ctest
CMD ["./app"]