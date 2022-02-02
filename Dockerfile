FROM ubuntu:18.04 as builder

LABEL maintainer="me@jeffersonbledsoe.com"
LABEL org.label-schema.name = "Skyscraper"
LABEL org.label-schema.description = "Powerful and versatile game scraper written in c++. Written by muldjord."
LABEL org.label-schema.url = "https://github.com/jeffersonbledsoe/skyscraper"
LABEL org.label-schema.vsc-url = "https://github.com/muldjord/skyscraper"
LABEL org.label-schema.schema-version = "1.0"
LABEL org.label-schema.docker.cmd = "docker run skyscraper"

# sudo needed as the skyscraper script may call it.
RUN apt-get update && apt-get install -y \
    build-essential \
    qt5-default \
    sudo \
    wget

RUN cd && mkdir skysource && cd skysource && \
    wget https://raw.githubusercontent.com/muldjord/skyscraper/master/update_skyscraper.sh && \
    chmod +x update_skyscraper.sh

RUN ~/skysource/update_skyscraper.sh

ENTRYPOINT [ "/usr/local/bin/Skyscraper" ]
