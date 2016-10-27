FROM        rayyildiz/java:jre8
MAINTAINER  Ramazan AYYILDIZ <rayyildiz@gmail.com>

ENV         KOTLIN_VERSION=1.0.4 \
            KOTLIN_HOME=/usr/local/kotlin

# https://github.com/JetBrains/kotlin/releases/download/v1.0.4/kotlin-compiler-1.0.4.zip

RUN         apk update && \
            apk add ca-certificates && \
            update-ca-certificates && \
            apk add openssl wget bash

RUN         cd  /tmp && \
            wget -k "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip"  && \
            unzip "kotlin-compiler-${KOTLIN_VERSION}.zip" && \
            mkdir -p "${KOTLIN_HOME}" && \
            mv "/tmp/kotlinc/bin" "/tmp/kotlinc/lib" "${KOTLIN_HOME}" && \
            rm ${KOTLIN_HOME}/bin/*.bat && \
            chmod +x ${KOTLIN_HOME}/bin/* && \
            ln -s "${KOTLIN_HOME}/bin/"* "/usr/bin/" && \
            apk del wget ca-certificates curl openssl && \
            rm -rf /tmp/* /var/cache/apk/*


CMD         ["kotlinc"]
