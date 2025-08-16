FROM python:3.10-slim

WORKDIR /code

COPY requirements.txt .

RUN apt-get update && apt-get install -y netcat-openbsd postgresql-client && \
    pip install --upgrade pip && pip install -r requirements.txt && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


COPY . .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
