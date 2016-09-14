FROM gentoo/stage3-amd64-hardened
MAINTAINER Fabian Köster <koesterreich@fastmail.fm>

# Install portage tree
RUN emerge-webrsync

# Enable compilation of storage daemon and postgres backend only
RUN echo -e "app-backup/bacula postgres -sqlite bacula-nodir \n dev-db/postgresql -server threads" > /etc/portage/package.use/bacula

# Use latest version of bacula
RUN echo "app-backup/bacula" > /etc/portage/package.keywords/bacula

# Install required packages
RUN emerge -q sys-fs/inotify-tools app-backup/bacula

VOLUME /etc/bacula
VOLUME /var/lib/bacula

COPY create_dhparam.sh entrypoint.sh /usr/local/bin/

ENTRYPOINT /usr/local/bin/entrypoint.sh

EXPOSE 9103
