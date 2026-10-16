FROM runwisp/runwisp:1.7.0-debian-docker

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    gzip \
    git \
    jq \
    python3 \
    python3-pip \
    unzip \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then YQ_ARCH="amd64"; \
    elif [ "$ARCH" = "arm64" ]; then YQ_ARCH="arm64"; \
    else YQ_ARCH="amd64"; fi && \
    curl -sL https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${YQ_ARCH} -o /usr/bin/yq && \
    chmod +x /usr/bin/yq

RUN curl -sL https://rclone.org/install.sh | bash