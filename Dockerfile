# =========================
# 第一阶段：构建依赖
# =========================
FROM python:3.11-slim-bookworm AS builder

ENV PIP_NO_CACHE_DIR=1 \
    PDM_IGNORE_SAVED_PYTHON=1 \
    PDM_VENV_IN_PROJECT=1

WORKDIR /project

# 先装系统依赖（减少层 & 利用缓存）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 安装 PDM
RUN pip install --upgrade pip setuptools wheel pdm

# 先只拷贝依赖文件（利用缓存）
COPY pyproject.toml pdm.lock README.md ./

# 安装依赖
RUN pdm sync -G bot --prod --no-editable

# =========================
# 第二阶段：运行环境
# =========================
FROM python:3.11-slim-bookworm AS runtime

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1

WORKDIR /app

# 安装运行时依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        nodejs \
        npm \
    && npm install -g pm2 \
    && rm -rf /var/lib/apt/lists/*

# （可选）只在需要时安装 pdm
# RUN pip install pdm

# 挂载目录（建议只保留必要的）
VOLUME ["/data"]

# 拷贝虚拟环境
COPY --from=builder /project/.venv /app/.venv

# 再拷贝代码（避免改代码导致依赖重装）
COPY . /app

# PM2 配置
COPY pm2.json /app/pm2.json

# 启动
CMD ["pm2-runtime", "pm2.json"]
