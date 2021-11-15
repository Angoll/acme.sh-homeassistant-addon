ARG BUILD_FROM
FROM $BUILD_FROM

ENV LE_CONFIG_HOME /data/acme.sh
ENV AUTO_UPGRADE $AUTO_UPGRADE

RUN apk --no-cache add -f \
  openssl \
  openssh-client \
  coreutils \
  bind-tools \
  curl \
  sed \
  socat \
  tzdata \
  oath-toolkit-oathtool \
  tar \
  libidn

#Install
RUN curl https://get.acme.sh | sh
RUN ln -s /root/.acme.sh/acme.sh /usr/local/bin/acme.sh && crontab -l | grep acme.sh | sed 's#> /dev/null##' | crontab -
RUN cp ${LE_CONFIG_HOME}/account.conf /default_account.conf

COPY data/entry.sh /entry.sh

RUN  chmod +x /entry.sh

ENTRYPOINT ["/entry.sh"]