FROM debian:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    cmake \
    git \
    build-essential \
    libjson-c-dev \
    libwebsockets-dev \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    tigervnc-viewer \
    autossh \
    nano \
    icewm \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd / && \
    rm -rf /ttyd

EXPOSE 8080

CMD ["ttyd", "-i", "0.0.0.0", "-p", "8080", "-o", "-W", "bash"]
