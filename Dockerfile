FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y curl gnupg2 && \
    rm -rf /var/lib/apt/lists/*

ENV HUB_VERSION=2.11.2
RUN mkdir /tmp/hub && \
    (curl -SL https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz | tar --strip 1 -zxC /tmp/hub) && \
    prefix=/usr /tmp/hub/install && \
    rm -rf /tmp/hub

ENV TENPURETO_VERSION=0.1.4
RUN echo "deb https://dl.bintray.com/tenpureto/deb-snapshots buster main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 && \
    apt-get update && \
    apt-get install -y tenpureto=${TENPURETO_VERSION}-buster && \
    rm -rf /var/lib/apt/lists/*

LABEL "com.github.actions.name"="Tenpureto"
LABEL "com.github.actions.description"="Tenpureto templates automation"
LABEL "com.github.actions.icon"="git-merge"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/rtimush/tenpureto"
LABEL "homepage"="https://github.com/rtimush/tenpureto"
LABEL "maintainer"="Roman Timushev <rtimush@gmail.com>"

ADD entrypoint.sh /usr/local/bin/
ADD hub /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
