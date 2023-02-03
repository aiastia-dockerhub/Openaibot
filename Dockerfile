FROM python:3.10-slim AS builder
ENV WORKDIR /app
WORKDIR $WORKDIR
ADD . $WORKDIR
RUN apt update && apt install build-essential git curl -y && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUN pip install --upgrade --no-cache-dir pip && pip install --no-cache-dir -r requirements.txt
