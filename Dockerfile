FROM alpine:latest

# Установка необходимых пакетов
RUN apk add --no-cache dropbear autossh

# Создание пользователя для SSH (опционально, но рекомендуется для безопасности)
RUN adduser -D -s /bin/sh tunneluser && \
    echo "root:vncroot" | chpasswd

# Настройка Dropbear (SSH-сервер)
RUN mkdir /etc/dropbear && \
    dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key && \
    dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key && \
    dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key

# Копируем SSH-ключ (если нужно, можно монтировать при запуске)
# COPY ssh.pem /home/tunneluser/.ssh/id_rsa
# RUN chmod 600 /home/tunneluser/.ssh/id_rsa

# Запуск Dropbear (SSH-сервер) и autossh (клиент для туннеля)
CMD ( \
    /usr/sbin/dropbear -RFEmwg -p 22 && \
    su tunneluser -c 'autossh -i ssh.pem -M 0 -o "StrictHostKeyChecking=no" -o "ServerAliveInterval 30" -o "ServerAliveCountMax 99999" -o "TCPKeepAlive=yes" DarkGlowing1.first@DarkGlowing1-45219.portmap.host -N -R 45219:172.31.17.127:8881' \
)
