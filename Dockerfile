ARG ALPINE_VERSION

FROM alpine:3.16.3

LABEL maintainer="jakobjs" \
      version="0.0.1"

ARG SERVICE_USER
ARG SERVICE_HOME

ENV SERVICE_USER ${SERVICE_USER:-alpine}
ENV SERVICE_HOME ${SERVICE_HOME:-/home/${SERVICE_USER}}

RUN apk add --no-cache \
        bash=5.1.16-r2 \
        curl=7.83.1-r4 \
        jq=1.6-r1 \
        yq=4.25.1-r5 \
        git=2.36.3-r0 \
        dumb-init=1.2.5-r1 \
        openssl=1.1.1s-r0

RUN adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \
    sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

USER    ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}
VOLUME  ${SERVICE_HOME}

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "curl", "--help" ]
