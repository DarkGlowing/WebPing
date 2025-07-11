# Use an official Ubuntu runtime as a parent image
FROM debian:latest

# Set environment variable for the port
ENV PORT=8080

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates autossh git nano curl wget icewm tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer && \
    update-ca-certificates && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose the correct port
EXPOSE $PORT

# Start code-server (listen on all interfaces)
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
