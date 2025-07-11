FROM debian:latest

RUN apt-get update && \
    apt-get install -y ttyd && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD ["ttyd", "-i", "0.0.0.0", "-p", "8080", "bash"]
