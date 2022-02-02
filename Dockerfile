FROM ubuntu:18.04 as builder

# sudo needed as the skyscraper script may call it.
RUN apt-get update && apt-get install -y \
    build-essential \
    qt5-default \
    sudo \
    wget

ARG VERSION=3.7.4

RUN cd && mkdir skysource && cd skysource && \
    wget https://raw.githubusercontent.com/muldjord/skyscraper/${VERSION}/update_skyscraper.sh && \
    chmod +x update_skyscraper.sh

RUN ~/skysource/update_skyscraper.sh


FROM ubuntu:18.04 as runner
LABEL maintainer="me@jeffersonbledsoe.com"

COPY --from=builder /lib/x86_64-linux-gnu/ /lib/x86_64-linux-gnu/
COPY --from=builder /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/
COPY --from=builder /usr/local/bin/Skyscraper /usr/local/bin/Skyscraper

ENTRYPOINT [ "/usr/local/bin/Skyscraper" ]
