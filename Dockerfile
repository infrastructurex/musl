FROM alpine:3.19.0 AS build

ARG ARCH
ENV ARCH=$ARCH
ARG LINUX_ARCH
ENV LINUX_ARCH=$LINUX_ARCH
ARG TAG
ENV TAG=$TAG

RUN apk add wget make gcc musl-dev linux-headers
ADD build.sh /build/build.sh
RUN /build/build.sh


FROM scratch AS export
COPY --from=build /musl.tar.gz .
