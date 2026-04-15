# 第一个阶段
FROM python:3.9-bullseye AS builder

RUN apt update && \
    apt install -y build-essential && \
    pip install -U pip setuptools wheel && \
    pip install pdm && \
    apt install -y ffmpeg

COPY pyproject.toml pdm.lock README.md /project/
WORKDIR /project
RUN pdm lock -G default -G bot && \
    pdm sync --prod --no-editable

# 第二个阶段
FROM python:3.9-slim-bullseye AS runtime

RUN apt update && \
    apt install -y curl gnupg ffmpeg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs && \
    npm install pm2 -g && \
    pip install pdm

VOLUME ["/redis", "/rabbitmq", "/mongodb", "/run.log", ".cache",".montydb",".snapshot"]

WORKDIR /app
COPY --from=builder /project/.venv /app/.venv

COPY pm2.json ./
COPY . /app

CMD [ "pm2-runtime", "pm2.json" ]