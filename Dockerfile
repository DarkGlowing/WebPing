# Используем базовый образ Ubuntu
FROM debian:latest

# Устанавливаем необходимые пакеты
RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    cmake \
    git \
    libjson-c-dev \
    libwebsockets-dev \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем ttyd (веб-терминал)
RUN git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Устанавливаем bash (если его нет)
RUN apt-get update && apt-get install -y --no-install-recommends bash && rm -rf /var/lib/apt/lists/*

# Открываем порт 8080
EXPOSE 8080

# Запускаем ttyd при старте контейнера
CMD ["ttyd", "-p", "0.0.0.0:8080", "bash"]
