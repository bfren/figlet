ARG ALPINE=3.24.2

# use Alpine (musl) to build - a static musl binary runs on any Linux distribution
FROM alpine:${ALPINE} AS build

# define ARGS
ARG FIGLET=2.2.5

# install prerequisites
RUN apk add build-base

# copy script files and source
WORKDIR /tmp
COPY ./verify.sh ./build.sh ./
COPY ./patches ./patches
COPY ./src/figlet-${FIGLET}.tar.gz ./src/figlet-${FIGLET}.tar.gz.sha256 ./
RUN chmod +x ./*.sh

# verify source, build and install to /out
RUN ./build.sh ${FIGLET}

# create blank image with only the figlet executable, its default font and licence
FROM scratch AS final
COPY --from=build /out /
