FROM ubuntu:12.04
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8 && update-locale en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y postgresql postgresql-contrib libpq-dev
ADD pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf
RUN chown postgres.postgres /etc/postgresql/9.1/main/pg_hba.conf
ADD postgresql.conf /etc/postgresql/9.1/main/postgresql.conf
RUN chown postgres.postgres /etc/postgresql/9.1/main/postgresql.conf

EXPOSE 5432
VOLUME /var/lib/postgresql
ADD pg_start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/pg_start.sh

ENTRYPOINT ["/usr/local/bin/pg_start.sh"]
