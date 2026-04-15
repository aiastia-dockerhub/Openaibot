# =========================
# 第一阶段：构建依赖
# =========================
FROM python:3.11-slim-bookworm AS builder

ENV PIP_NO_CACHE_DIR=1 \
    PDM_IGNORE_SAVED_PYTHON=1 \
    PDM_VENV_IN_PROJECT=1

WORKDIR /project

# 安装构建依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ffmpeg \
        curl \
    && rm -rf /var/lib/apt/lists/*

# 安装 PDM
RUN pip install --upgrade pip setuptools wheel pdm

# 只复制依赖文件（利用缓存）
COPY pyproject.toml pdm.lock README.md ./

# ⚠️ 关键：使用 -E bot（不是 -G）
RUN pdm sync --prod --no-editable -E bot

# =========================
# 第二阶段：运行环境
# =========================
FROM python:3.11-slim-bookworm AS runtime

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1

WORKDIR /app

# 安装运行依赖 + Node（新版）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        curl \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs \
    && npm install -g pm2 \
    && rm -rf /var/lib/apt/lists/*

# 拷贝虚拟环境
COPY --from=builder /project/.venv /app/.venv

# 拷贝代码
COPY . /app

# （可选）防止 python 命令不存在
RUN ln -s /usr/local/bin/python /usr/bin/python || true

# 启动
CMD ["pm2-runtime", "pm2.json"]
