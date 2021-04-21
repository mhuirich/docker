################################################################################

FROM alpine:3.13.5 AS alpine-ghc-base

RUN apk upgrade --no-cache &&\
    apk add --no-cache \
        curl \
        gcc \
        git \
        libc-dev \
        xz \
        gmp-dev

################################################################################

FROM alpine-ghc-base

ENV GHC_VERSION=8.10.4
ENV PATH=/root/.ghcup/bin:$PATH
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=true

RUN echo "Install OS packages necessary to build GHC" &&\
    apk add --no-cache \
        autoconf \
        automake \
        binutils-gold \
        build-base \
        coreutils \
        cpio \
        ghc \
        linux-headers \
        libffi-dev \
        llvm \
        musl-dev \
        ncurses-dev \
        perl \
        python3 \
        py3-sphinx \
        zlib-dev

RUN curl https://get-ghcup.haskell.org -sSf | sh
RUN source /root/.ghcup/env
RUN ghcup install ghc --set $GHC_VERSION
RUN ghcup install cabal
COPY ghci.conf /root/.ghc/ghci.conf
RUN cabal install --lib pretty-simple && \
        cabal install --lib protolude

ENTRYPOINT ["ghci"]

################################################################################
