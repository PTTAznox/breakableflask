#BUILD STAGE
FROM python:3.11-slim AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --chown=appuser:appuser requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


#RUNTIME STAGE
python:3.11-slim

RUN useradd -m appuser

WORKDIR /app


COPY --from=builder /install /usr/local
COPY --chown=appuser:appuser . /app

USER appuser

EXPOSE 4000
CMD ["python", "main.py"]
