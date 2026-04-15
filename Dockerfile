# =========================
# builder
# =========================
FROM python:3.11-slim-bookworm AS builder

ENV PIP_NO_CACHE_DIR=1 \
    PDM_IGNORE_SAVED_PYTHON=1 \
    PDM_VENV_IN_PROJECT=1

WORKDIR /project

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ffmpeg \
        curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools wheel pdm

COPY pyproject.toml pdm.lock README.md ./

# ✅ 关键修复点
RUN pdm install --prod --no-editable -E bot

# =========================
# runtime
# =========================
FROM python:3.11-slim-bookworm

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        curl \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs \
    && npm install -g pm2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /project/.venv /app/.venv
COPY . /app

CMD ["pm2-runtime", "pm2.json"]
