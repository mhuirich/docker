################################################################################

FROM alpine:3.13.5 AS alpine-ghc-base

ENV UPX_REPO=https://github.com/upx/upx
ENV UPX_VERS=3.96
ENV UPX_DIR=upx-${UPX_VERS}-amd64_linux
ENV UPX_FILE=${UPX_DIR}.tar.xz

RUN apk upgrade --no-cache && \
        apk add --no-cache \
        bash \
        curl \
        gcc \
        git \
        libc-dev \
        xz \
        gmp-dev
RUN curl -O -L ${UPX_REPO}/releases/download/v${UPX_VERS}/${UPX_FILE} && \
        tar xvf $UPX_FILE && \
        mv ${UPX_DIR}/upx /bin/upx

################################################################################

FROM alpine-ghc-base AS ghc-base

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

ENTRYPOINT ["ghci"]

################################################################################

FROM ghc-base

RUN ghcup install cabal
RUN cabal install --lib pretty-simple && \
        cabal install --lib protolude
COPY ghci.conf /root/.ghc/ghci.conf

################################################################################
