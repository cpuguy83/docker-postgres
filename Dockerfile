FROM cpuguy83/ubuntu

RUN apt-get update && apt-get install -y postgresql postgresql-contrib libpq-dev
ADD pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf
RUN chown postgres.postgres /etc/postgresql/9.1/main/pg_hba.conf
ADD postgresql.conf /etc/postgresql/9.1/main/postgresql.conf
RUN chown postgres.postgres /etc/postgresql/9.1/main/postgresql.conf
RUN echo "kernel.shmmax = 4418740224" >> /etc/sysctl.conf && sysctl -p
RUN sysctl -w kernel.shmmax=4418740224 && /etc/init.d/postgresql start && su postgres -c "createuser -s -d root && psql -c \"ALTER USER root with PASSWORD 'pgpass'; CREATE USER replication REPLICATION LOGIN CONNECTION LIMIT 1 ENCRYPTED PASSWORD 'replpass'\""

EXPOSE 5432
VOLUME /var/lib/postgresql
ADD pg_start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/pg_start.sh

CMD ["/usr/local/bin/pg_start.sh"]
