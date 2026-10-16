FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=appuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

# Install system dependencies and official Docker CLI + Compose plugin
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    gzip \
    git \
    jq \
    python3 \
    python3-pip \
    unzip \
    openssh-client \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update && apt-get install -y --no-install-recommends \
    docker-ce-cli \
    docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# Install yq
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then YQ_ARCH="amd64"; \
    elif [ "$ARCH" = "arm64" ]; then YQ_ARCH="arm64"; \
    else YQ_ARCH="amd64"; fi && \
    curl -sL https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${YQ_ARCH} -o /usr/bin/yq && \
    chmod +x /usr/bin/yq

# Install rclone
RUN curl -sL https://rclone.org/install.sh | bash

# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME