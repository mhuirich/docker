# Note: this image is 3+GB in size, and built locally -- not downloaded from
#       Docker Hub. See mhuirich/docker/Makefile for more details.
FROM mhuirich/haskell:8.10.4-alpine3.13.5

ARG APP
 
COPY ${APP}.hs /build/

WORKDIR /

RUN ghc -o /build/${APP} /build/${APP}.hs
RUN mkdir -p /app && \
        cp /build/${APP} /app/ && \
        upx /app/${APP}

ENV APP_NAME $APP
RUN echo "#!/bin/sh" > /app/entrypoint.sh && \
        echo "/app/${APP_NAME}" >> /app/entrypoint.sh && \
        chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
