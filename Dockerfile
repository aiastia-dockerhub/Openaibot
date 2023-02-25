FROM python:3.11-slim-bullseye as builder

# Tiktoken requires Rust toolchain, so build it in a separate stage
RUN apt-get update && apt-get install -y gcc curl build-essential -y
COPY ./requirements.txt .
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && apt-get install --reinstall libc6-dev -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN pip install --upgrade pip && pip install tiktoken

FROM python:3.11-slim-bullseye
ENV WORKDIR /app
WORKDIR $WORKDIR
ADD . $WORKDIR
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages


