FROM postgres:latest

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

COPY DatabaseCreation.sql /docker-entrypoint-initdb.d/

EXPOSE 5432