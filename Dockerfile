FROM alpine:latest

# Установка необходимых пакетов
RUN apk add --no-cache dropbear autossh git

# Создание пользователя для SSH (опционально, но рекомендуется для безопасности)
RUN adduser -D -s /bin/sh tunneluser && \
    echo "root:vncroot" | chpasswd

# Запуск Dropbear (SSH-сервер) и autossh (клиент для туннеля)
CMD ( \
    /usr/sbin/dropbear -RFEmwg -p localhost:8881 & \
    su tunneluser -c 'nohup autossh -i ssh.pem -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 99999" -o "TCPKeepAlive=yes" DarkGlowing1.first@DarkGlowing1-45219.portmap.host -N -R 45219:172.31.17.127:8881 &> /dev/null &' \
    && sleep infinity
)
)
