#!/bin/sh

set -e

host="$1"
shift
cmd="$@"

until pg_isready -h "$host" -p 5432; do
  echo "Esperando o Postgres em $host..."
  sleep 2
done

echo "Postgres está pronto! Iniciando aplicação..."
exec $cmd
