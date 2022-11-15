FROM alpine:3.16.3

LABEL maintainer="jakobjs" \
      version="1.0.0"

ARG SERVICE_USER
ARG SERVICE_HOME

ENV SERVICE_USER ${SERVICE_USER:-alpine}
ENV SERVICE_HOME ${SERVICE_HOME:-/home/${SERVICE_USER}}

RUN apk add --no-cache \
        bash=5.2.9 \
        curl=7.86.0 \
        jq=1.6 \
        yq=4.28.1 \
        git=2.38.1 \
        dumb-init=1.2.5 \
        openssl=3.0.7

RUN adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \
    sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

USER    ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}
VOLUME  ${SERVICE_HOME}

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "curl", "--help" ]
