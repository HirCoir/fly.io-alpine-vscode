FROM martinussuherman/alpine:3.13-amd64-glibc

ENV \
   # container/su-exec UID \
   EUID=1001 \
   # container/su-exec GID \
   EGID=1001 \
   # contenedor/nombre de usuario su-exec\
   EUSER=vscode \
   # nombre del grupo container/su-exec \
   EGROUP=vscode \
   # ¿Debe el shell de usuario establecerse en nologin? (yes/no) \
   ENOLOGIN=no \
   # directorio de inicio del usuario del contenedor \
   EHOME=/home/vscode \
   # versión de vscode \
   VERSION=4.4.0 \
   # Define la contraseña de VSCODE \
   PASSWORD=12345

COPY code-server /usr/bin/
RUN chmod +x /usr/bin/code-server

# Instalar dependencias
RUN \
   apk --no-cache --update add \
   bash \
   curl \
   git \
   gnupg \
   nodejs \
   openssh-client \
   npm

RUN \
   wget https://github.com/cdr/code-server/releases/download/v$VERSION/code-server-$VERSION-linux-amd64.tar.gz && \
   tar x -zf code-server-$VERSION-linux-amd64.tar.gz && \
   rm code-server-$VERSION-linux-amd64.tar.gz && \
   mv code-server-$VERSION-linux-amd64 /usr/lib/code-server

CMD dd if=/dev/zero of=/swapfile bs=2048 count=1048576; \
    chmod 600 /swapfile; \
    mkswap /swapfile; \
    swapon /swapfile; \
    sysctl vm.swappiness=10; \
    code-server --bind-addr 0.0.0.0:8080
