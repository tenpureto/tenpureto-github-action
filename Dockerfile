FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y curl gnupg2 jq && \
    rm -rf /var/lib/apt/lists/*

ENV HUB_VERSION=2.12.8
RUN mkdir /tmp/hub && \
    (curl -SL https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz | tar --strip 1 -zxC /tmp/hub) && \
    prefix=/usr /tmp/hub/install && \
    rm -rf /tmp/hub

ENV TENPURETO_VERSION=0.4.0
RUN echo "deb https://dl.bintray.com/tenpureto/deb-snapshots buster main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 && \
    apt-get update && \
    apt-get install -y tenpureto=${TENPURETO_VERSION}-buster && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

ENV HUB_PROTOCOL=https
ENV GITHUB_USER=github-action
ENV GIT_AUTHOR_NAME=Tenpureto
ENV GIT_AUTHOR_EMAIL=github-action@tenpureto.org
ENV GIT_COMMITTER_NAME=Tenpureto
ENV GIT_COMMITTER_EMAIL=github-action@tenpureto.org

LABEL "com.github.actions.name"="Tenpureto"
LABEL "com.github.actions.description"="Tenpureto templates automation"
LABEL "com.github.actions.icon"="git-merge"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/tenpureto/tenpureto-github-action"
LABEL "homepage"="http://tenpureto.org"
LABEL "maintainer"="Roman Timushev <rtimush@gmail.com>"

ENV PULL_REQUEST_LABEL=""

ADD *.sh /usr/local/bin/

ENV GIT_ASKPASS="/usr/local/bin/askpass.sh"

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
