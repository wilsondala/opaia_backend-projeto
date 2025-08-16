#!/bin/sh

export PYTHONPATH=/code

# Loop para tentar conexão com o Postgres via python
until python -c "import psycopg2; psycopg2.connect('dbname=opaia user=postgres password=postgres host=db')" 2>/dev/null; do
  echo "Waiting for Postgres..."
  sleep 1
done

echo "Postgres is up - running migrations..."
python /code/app/create_tables.py

echo "Starting FastAPI server..."
exec uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
