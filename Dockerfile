FROM cpuguy83/ubuntu

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
