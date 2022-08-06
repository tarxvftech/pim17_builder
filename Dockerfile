ARG DVER=3.15
FROM docker.io/alpine:$DVER as keys
RUN apk add --no-cache alpine-keys

FROM docker.io/alpine:edge

RUN sed -E -e "s/^(.*community)/\1\n\1/" -e "s/(.*)community/\1testing/" -i /etc/apk/repositories

RUN apk add --no-cache --upgrade dosfstools e2fsprogs-extra findutils \
	genimage git m4 mtools pigz 

ADD ./resources /resources
COPY --from=keys /usr/share/apk/keys /usr/share/apk/keys-stable

RUN install /resources/scripts/find-deps.sh /usr/local/bin/find-deps && \
    install /resources/scripts/find-mods.sh /usr/local/bin/find-mods 

WORKDIR /work

CMD ["/bin/sh", "/resources/build.sh"]
