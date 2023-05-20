FROM ubuntu:bionic

#Install Basic tools & create user
ENV MAIN_PKGS="\
        curl telnet netcat vim less nano zip unzip librdkafka1 librdkafka-dev liblzma-dev \
        build-essential wget xz-utils libpopt-dev \
        checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
        tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev \
        bash git libpq-dev gcc make g++ openssh-server ant rsync net-tools" \
    TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive \
    PYKERBEROS_PACKAGES="\
        gcc libgssapi-krb5-2 libkrb5-dev \
        libssl-dev libsasl2-dev \
        libsasl2-modules-gssapi-mit \
        python3.8-dev supervisor"

RUN apt update && \
    apt install -y wget && \
    apt-get install -y software-properties-common && \
    wget -qO - https://packages.confluent.io/deb/6.2/archive.key | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/6.2 stable main" && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends ${MAIN_PKGS} && \
    apt install -y python python3.8 python3.8-venv && \
    apt install -y ${PYKERBEROS_PACKAGES} && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.8 get-pip.py && rm get-pip.py && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    apt-get clean && update-ca-certificates -f && \
    rm -rf /var/lib/apt/lists/*

ENTRYPINT ["tail", "-f", "/dev/null"]
