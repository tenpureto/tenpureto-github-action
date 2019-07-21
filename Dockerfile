FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y curl gnupg2 && \
    rm -rf /var/lib/apt/lists/*

ENV HUB_VERSION=2.12.3
RUN mkdir /tmp/hub && \
    (curl -SL https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz | tar --strip 1 -zxC /tmp/hub) && \
    prefix=/usr /tmp/hub/install && \
    rm -rf /tmp/hub

ENV TENPURETO_VERSION=0.2.2
RUN echo "deb https://dl.bintray.com/tenpureto/deb-snapshots buster main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 && \
    apt-get update && \
    apt-get install -y tenpureto=${TENPURETO_VERSION}-buster && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

ENV HUB_PROTOCOL=https
ENV GITHUB_USER=github-actions

LABEL "com.github.actions.name"="Tenpureto"
LABEL "com.github.actions.description"="Tenpureto templates automation"
LABEL "com.github.actions.icon"="git-merge"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/rtimush/tenpureto"
LABEL "homepage"="https://github.com/rtimush/tenpureto"
LABEL "maintainer"="Roman Timushev <rtimush@gmail.com>"

ENV PULL_REQUEST_LABEL=""

ADD entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
