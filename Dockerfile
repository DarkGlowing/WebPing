FROM debian:latest

RUN apt-get update && \
    apt-get install -y wget curl build-essential git openssh-client && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xvzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/ && \
    rm gotty_linux_amd64.tar.gz

EXPOSE 8080

CMD ["gotty", "--port", "8080", "--address", "0.0.0.0", "bash"]
