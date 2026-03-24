FROM docker/sandbox-templates:claude-code

USER root

ARG GLAB_VERSION=1.90.0
ARG HUB_VERSION=2.14.2
RUN apt-get update && apt-get install -y curl ripgrep \
  && rm -rf /var/lib/apt/lists/* \
  && curl -fsSL "https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_$(dpkg --print-architecture).deb" -o /tmp/glab.deb \
  && dpkg -i /tmp/glab.deb && rm /tmp/glab.deb \
  && curl -fsSL "https://github.com/mislav/hub/releases/download/v${HUB_VERSION}/hub-linux-$(dpkg --print-architecture)-${HUB_VERSION}.tgz" -o /tmp/hub.tgz \
  && tar xzf /tmp/hub.tgz -C /tmp \
  && cp /tmp/hub-linux-*/bin/hub /usr/local/bin/ \
  && rm -rf /tmp/hub*

USER agent
ENV HOME=/home/agent
ENV TERM=xterm-256color
ENV COLORTERM=truecolor

ENV NVM_DIR="$HOME/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

ARG HOST_HOME
ENV HOST_HOME="${HOST_HOME}"
RUN rm -rf "$HOME/.claude" && ln -s "${HOST_HOME}/.claude" "$HOME/.claude"

COPY docker_root/ /
