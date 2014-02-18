docker-postgres
===============

Runs postgres as either standalone, or master/slave

### Configuration Options (Env vars)
```
ROOT_PASS=pgpass # sets the root password
REPLICATION_USER=replication # sets the replication user
REPLICATION_PASS=replpass # sets the replication user's password
MASTER_HOST=$MASTER_PORT_5432_TCP_ADDR # sets the master host address
PG_CONFIG= # Passes into postgres process
NO_REPLICATION= # Disables setting up replication user if set
```
Make sure to look at and change these defaults as they are not secure.<br />
Give special attention to the NO_REPLICATION setting, if this is NOT set then a replication user will be created

You can either pass these options into the docker or add your customisations to /etc/default/postgres

