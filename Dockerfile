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
