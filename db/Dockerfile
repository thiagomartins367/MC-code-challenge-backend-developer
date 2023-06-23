FROM mysql:8.0.33 AS db_prod

WORKDIR /usr/src/database

ADD ./init_db.sql /docker-entrypoint-initdb.d/0_init_db.sql

RUN chmod -R 775 /docker-entrypoint-initdb.d
