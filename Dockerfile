FROM mysql:5.7

RUN apt-get update && \
    apt-get install --no-install-suggests -y wget && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# Install Supercronic for Cron jobs
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.6/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=c3b78d342e5413ad39092fd3cfc083a85f5e2b75

RUN wget "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

# Default Environment Vars
ENV CRON_SCHEDULE 0 0 * * *
ENV MYSQL_HOST mysql
ENV MYSQL_PORT 3306
ENV MYSQL_USER root
ENV MYSQL_PASSWORD password

# Create backup storage dir
RUN mkdir -p /backup

# Copy in scripts
ADD scripts/* /
RUN chmod 744 /*.sh

CMD ["bash", "/docker-cmd.sh"]
