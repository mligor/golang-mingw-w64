FROM golang:1.10.2

RUN apt-get update
RUN apt-get install -y -qq mingw-w64
RUN ln -s /usr/bin/x86_64-w64-mingw32-windres /usr/bin/windres
RUN apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    rm -rf /var/lib/apt/lists/*
