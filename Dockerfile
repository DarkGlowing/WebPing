FROM alpine:latest

# Установка необходимых пакетов
RUN apk add --no-cache dropbear autossh git

# Создание пользователя для SSH (опционально, но рекомендуется для безопасности)
RUN adduser -D -s /bin/sh tunneluser && \
    echo "root:vncroot" | chpasswd

RUN git clone https://github.com/DarkGlowing/ssh.git && cd ssh && chmod 600 ssh.pem && autossh -i ssh.pem -M 0 -o "StrictHostKeyChecking=no" -o "ServerAliveInterval 30" -o "ServerAliveCountMax 99999" -o "TCPKeepAlive=yes" DarkGlowing1.first@DarkGlowing1-45219.portmap.host -N -R 45219:172.31.17.127:8881

# Запуск Dropbear (SSH-сервер) и autossh (клиент для туннеля)
CMD ( \
    /usr/sbin/dropbear -RFEmwg -p 22 \
)
