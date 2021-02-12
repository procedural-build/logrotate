FROM linkyard/logrotate:latest

ENV DOCKER 19.03.12
ENV CURL 7.69.1-r3

RUN apk add --no-cache curl=$CURL

# Download Docker
RUN if [ -f /usr/local/bin/docker ]; then echo "Docker already installed"; else \
    curl -o /root/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER.tgz && \
    tar -C /root -xvf /root/docker.tgz && \
    mv /root/docker/docker /usr/local/bin/docker && \
    rm -rf /root/docker* ;\
    fi