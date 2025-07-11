# Use an official Ubuntu runtime as a parent image
FROM debian:latest

# Set environment variable for the port
ENV PORT=8080

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates lxqt qterminal falkon autossh git nano curl wget lxqt tigervnc-standalone-server tigervnc-xorg-extension && \
    update-ca-certificates && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.config/code-server && \
    cat > /root/.config/code-server/config.yaml <<EOF
bind-addr: 0.0.0.0:8080
auth: password
password: encryptroot
disable-telemetry: true
disable-update-check: true
EOF

EXPOSE $PORT
CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]
