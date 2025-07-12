# Use an official Ubuntu runtime as a parent image
FROM ubuntu:24.04

# Set environment variable for the port
ENV PORT=8080

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates icewm autossh git nano curl wget xorg tightvncserver epiphany python3 && \
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

RUN cat > /root/lxde.pem <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpgIBAAKCAQEA5gmtZLkEUBJI/jF6o6E03Cb20Uf34BGipaW9TyCzuGxJ/rfP
tKa/bMpObhRT9gzCWMdyL2jf5mVT0vrG6JYbHTgdHwRl6R1HJgqy89KXPgUQ1cvH
ZgIElp8NgVbzGyk8KHKzTK/vEmP2lnPu23WB3R36CwiYkyfEBJb+j+kHP35ER0+Q
D66pe5S7+S8xiA0jtUEwekmciYz1EV3UUnUs2Pu4xaPNHUOchIyy2NQajXmdeQY8
bEFAxPPFJmunMt1LTx9I3kV9xbL3a1Om9UoXioMVD5lVPYRV0KlXN+1Ly6amenap
xTI1yawVAjtl7fy21dgPpAqOijmDG1j3SfYyDQIDAQABAoIBAQCL3yyARwN5UHTz
otBIOFg02LhQ7mqo4vA7unhOabr9k1K2v7taw903YBeqVU/sFzwA0Vz7uNATfl8m
tPdHKyZXcOw8FOeGhBfj6LOBD/aIbnobFWor+2Qg1ZtXnq/5PuxmR8AADCXYz9F7
EAkXhe6trXGBTfu/1nkYtVsZ0/5lOtEk9weD/5sH4jDVeoV7JDm/nKfCQ/qbfpZ4
pXLs75hdnD9GU/WilqOwL/umqgCwiOqeZ+y5cCwHZ1aMJISAHK5E9sioet4cYlco
k539Mmcb9IX3qc/JndYNWhS+yrp3Zk9GMCtLzpIk0zI0kkjc12YCvunUpVO/3JtU
sfkcJj19AoGBAPwASwnehtVJj1iR5/d2NrFOrRIod701fgabvPEPI5U6/vQGE1R+
4Xp5/oEYAymDX6cd/II7yF3tdyAO2HSlyJ0XzycN356VSrZy4QqTnAmZ0JkyfK1N
GUam1tmZjbz16P11g/X4r5CtIY0wGtj/rFMXCKyvNWnnJ64EUicbYySzAoGBAOmw
KYtHo8JJsWfnDEJGjpX9+fDAvhy4zVv/dheWBWyk3SLitb0NftQNS1aUSrrxnVzs
U0wHxnZdU9AKotlndY5IjIdmKB490xk0dURRsZ/Wz1D+VUoQsjDP+MdTLKM+c4Ay
SZ6N1GtpqX7Ii6IxwrQmfdijfn8nSpOZZFoAKC4/AoGBAOvlxljNw4BDpPlvVCs1
sQsXsDHQSg6H1ZqQDTXHSzL2EBYU3eF6CM6jBpiIBuXEgjUpf+fV2MH8ekg7PWss
ifhsglF3zj5gWJkkPv+soCPopfnS5h1AkAmwQm1eLe2WcW1apZYLHyYau860Gl3K
MOFzLX6hYSnq5h0jFFhhbdS7AoGBAL+0f3A99e5VzA6DsT/RZ/lOH7NMOumPBRDa
kgMpVAvbd3m95/9OSeQlf89n2aJgwYpQaMjve/Tv/OinQQ7+W6a8h2Qv/utIJpv/
t8+zAPcyHmLAMjGPXs7CXcEOz4ifm9rn5hMHIOJ5DM3wMPR+w85L4WNORGCFWB2b
cYKPrGa7AoGBAIv2z23d74ZbipTLKa/n3CAB9f2pPTMYXCPRmGobY1t8VoiL9YVe
aTIHkdr0KHErOpd0Jt/os2vZTYw2XfeIrP1G7DdLJXzKG84uyV6Y2g5RkmLhQdgt
DdV6c2of162UafbWBzm9Pm6TML4az5VQT27piT21Koocdzyann3eS4nW
-----END RSA PRIVATE KEY-----
EOF

RUN chmod 600 /root/lxde.pem

EXPOSE $PORT
CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]
