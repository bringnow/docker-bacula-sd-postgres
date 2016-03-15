FROM gentoo/stage3-amd64-hardened
MAINTAINER Fabian Köster <koesterreich@fastmail.fm>

# Install portage tree
RUN emerge-webrsync

RUN echo -e "app-backup/bacula postgres -sqlite bacula-nodir \n dev-db/postgresql -server threads" > /etc/portage/package.use/bacula

# Install required packages
RUN emerge -q app-backup/bacula

VOLUME /etc/bacula
VOLUME /var/lib/bacula

CMD /usr/sbin/bacula-sd -c /etc/bacula/bacula-sd.conf -f

EXPOSE 9101
