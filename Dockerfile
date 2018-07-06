FROM ubuntu:16.04
MAINTAINER BirdZhang 0312birdzhang@gmail.com
RUN apt update && \
    apt install -y inotify-tools createrepo nginx && \
    apt autoremove && apt clean && \
    rm -rf /var/lib/apt/lists/*
ADD start.sh /
ADD default /etc/nginx/sites-available/
EXPOSE 80
CMD ["bash","/start.sh"]
