# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Set environment variable for the port
ENV PORT=8080

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates lxqt-* qterminal falkon autossh git nano curl wget lxqt tigervnc-standalone-server tigervnc-xorg-extension tigervnc-common && \
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

RUN mkdir -p /root/.vnc && \
    cat > /root/.vnc/config <<EOF
SecurityTypes=None
AlwaysShared=1
rfbport=6501
EOF

RUN cat > /root/lxde.pem <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAop8SB8njt2vhJlRyhByJBaR3vvXBSXD2TcezyZ/9xgttnppf
XRy2E/ARIhN7yPraBHloRgT1KeA3zTHQ8sf88suYSyFUWHLmmdHm4o/oRh/m/ATd
4/ITHMJuW7gIKYl55JOP3sHUcgRiFC1+I3Dm2F5Z/I1TEYeEvk/lz3qfsjagnkXb
/LMJrNMdLXK1CvrrtBD2jsLD57WWDQye+AljxxYKXRQNTkAN/aw3mk64DR1G47z9
l8oL39pyX4utAiiATCF0udHfSxXaJfJyOMAsKeeWh0LF1Q4UB29nZzQ72FbpZ/WM
FEUUPzDADwYIXcKqN6wYZg38J3iCcFhQl1uYQQIDAQABAoIBAFv3h9PdyilmGht6
MJUkKh2FyK62/wuQlcqhAL0q/PKubdz/QqU+4n3eC2JxEFU2AGv9WQoYLan0ArrJ
zHgwv41ztHnwrGmk+WLOQTup1NsrmY63FeGeek6Oaqj2J6+N7uBkzz1T8thUQD9X
Bvn2FKcSnONl7S+Bq4GRX875cyzuLuacADjbyVZnqGwgvSVyK1LWoFbv+qxaxTAl
rHIsu4AuY8d5nQCbpDYrthnoCy249BJDYh5etdGe97ePiT5jIV/aWClP7dJNMXco
M6/y2JLjwXOCg/EAwZizKWT+BDJHdTixbrubWdvQvWC72QsQTRON/YDq4NlQat19
/o07yp0CgYEA1Lax+yhhhis+2J2sackZX90u3+xNJLHxYALKqo7BtnvL12jdQuP7
MAQg7rdEGFrXO60dfPTwaK824DNd9A5oa9wGY8I+fA5Xudow6kRqNmX1RN1PBrf8
ZHmwTiMp3af9/mEBjh44gpIxmqoWNWNaoGp/l0UPwExKFKCv/qCPeh8CgYEAw7bS
GV2MvcC+wwh9aGIwx6Q59cX7E+sAFB6dLi1GudoW1K3ZHM1ayqnl7rBenUC7muUD
CDDZQ18h69n5ik0+aBAgNIG9LpNUqZD9HQDCETdeq1Loij4Z6HVoRmq0NOxnbTLL
k0ehA7Rzx20QonoI1DzJQUsm2Xnn8K6EltHnYZ8CgYEAliIcnNhzfO8o/FrNRhzZ
+/9xBjsSd8PgSZOu15LKxrG5veAVyxB+SfWgCNzxAv+aylP1bCy1Qi3o3XVj6s4A
haBWIjMHRygYYuTNgYuoK5zq8CADlwpk6cW52myXMAtSCikNn/FUkVP+DtvdsPDf
FjoUs//aji9KWiTQEzfgDKECgYBSJQLL+LLg1ex7Sa3xSP02XhyhpoY6lvECgNLy
FbjQutPIUmuFJkAMPgEvDMG5ePkFC0gZgP8/wscnCecuADvIS7RotWelC9uGDD/g
k3fg5/+JIxRNKcGQCu9IVvLqH6tNbvt5BqBzQKMzufg4acYY5qaGDDfzIbKTF3y5
HMLj+wKBgBw03PaluVkA7fO9W0Cj+QqRVou1TyL2SHKu9zML03DqSJiyEbs1Mkrh
M4cpCp+HSYfxHMm2a69tuDW/Rw2vrQACuuNEXKgAxOJpMshghVv4uKbEXEjvXba7
/6RBlc2Z8vDbOYhfJaLBS6wBGvBR2DfbWfNGq1t6pUHtycyGo85w
-----END RSA PRIVATE KEY-----
EOF

RUN chmod 600 /root/lxde.pem

EXPOSE $PORT
CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]
