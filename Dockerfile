# Dockerfile for building Debian packages using current stable repo.
FROM debian:bookworm
MAINTAINER Projecte Linkat <linkat@xtec.cat>

#COPY sources-list /etc/apt/sources.list
RUN set -ex \
    && sed -i -- 's/Types: deb/Types: deb deb-src/g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y --no-install-recommends \
  	devscripts \
  	equivs \
  	rsync \
  	locales \
  	gnupg2 \
  	debsigs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

VOLUME /package

COPY packagebuild /usr/local/bin/
COPY devscripts /root/.devscripts

RUN chmod 755 /usr/local/bin/packagebuild
ENTRYPOINT ["packagebuild"]
