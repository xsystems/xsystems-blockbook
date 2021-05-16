ARG BASE_IMAGE


FROM blockbook-build:latest AS builder

ARG BLOCKBOOK_VERSION

ENV PACKAGER="0:0" \
    VERSION="${BLOCKBOOK_VERSION}"

RUN git clone https://github.com/trezor/blockbook.git /src \
 && (cd /src && git checkout "tags/${BLOCKBOOK_VERSION}" -b "release/${BLOCKBOOK_VERSION}") \
 && make build


FROM ${BASE_IMAGE}

RUN apt-get update \
 && apt-get install -y \
        gettext-base \
        libsnappy1v5 \
        libzmq5 \
        wait-for-it \
 && rm -rf /var/lib/apt/lists/*

COPY    --from=builder \
        /build/blockbook \
        /build/ldb \
        /build/sst_dump \
        /blockbook/bin/

COPY    --from=builder \ 
        /src/static/ \
        /blockbook/static/

COPY    entrypoint.sh \
        blockchaincfg-template.json \
        /blockbook/

WORKDIR blockbook

ENTRYPOINT ["/blockbook/entrypoint.sh"]
