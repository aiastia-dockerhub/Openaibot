# OpenaiBot/LLMBot

[![Docker Image Size (tag)](https://img.shields.io/badge/Docker-Image-blue)](https://hub.docker.com/repository/docker/sudoskys/llmbot/general)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/sudoskys/llmbot)
![docker workflow](https://github.com/llmkira/openaibot/actions/workflows/docker-ci.yaml/badge.svg)

[![Telegram](https://img.shields.io/badge/Join-Telegram-blue)](https://t.me/Openai_LLM)
[![Discord](https://img.shields.io/badge/Join-Discord-blue)](https://discord.gg/6QHNdwhdE5)

[中文手册](README_CN.md)

LLMBot is a message queue based IM Bot developed around the concept of an intelligent robot assistant that can be loaded
with plugins to perform many functions. Implemented with Openai's new Feature `gpt-function-call`
support.

Unlike previous projects, this project tries to replicate ChatGpt's plugin system based on the messaging platform,
implementing some or more features.

> Because func call is a feature, it only supports Openai type api, and does not intend to support LLM without func
> call.

## 📦 Feature

- 🍪 Call a number of pre-defined functions in natural language.
- 📝 Messaging system, define send receivers and data can be delivered to the llm chain.
- 📎 Subscription system, which can subscribe to multiple senders in addition to paired senders, with push functionality.
- 📦 Non-question-and-answer binding, unlimited time and unlimited sender triggered response.
- 📬 Customizable ApiKey and Endpoint, traceability of sender authentication info.
- 🍾 Easy Interactive Experience.
- 🎵 Fine-grained consumption data storage, statistics on plugin credit consumption.

### 🧀 Preview of some plugins

| Sticker Converter                   | Timer Func                      | Translate                                    |
|-------------------------------------|---------------------------------|----------------------------------------------|
| ![sticker](./docs/sticker_func.gif) | ![timer](./docs/timer_func.gif) | ![translate](./docs/translate_file_func.gif) |

## 📝 Deployment Guide

Make sure your system is UTF8, `dpkg-reconfigure locales`

### Docker

```shell
docker-compose -f docker-compose.yml -p llmbot up -d llmbot --compatibility
```

### PM2

````
apt install npm
npm install pm2 -g
pm2 start pm2.json
````

### Shell

- (Optional) Resolving conflicts

  `pip uninstall llm-kira`

- 🛠 Configure the `.env` file

```bash
cp .env.example .env
```

- ⚙️ Install dependencies

```bash
pip install -r requirements.txt
```

- 🗄 Configure the database environment

```bash
# Install Redis
apt-get install redis
systemctl enable redis.service --now
```

```bash
# Install RabbitMQ
docker pull rabbitmq:3.10-management
docker run -d -p 5672:5672 -p 15672:15672 \
        -e RABBITMQ_DEFAULT_USER=admin \
        -e RABBITMQ_DEFAULT_PASS=admin \
        --hostname myRabbit \
        --name rabbitmq \
        rabbitmq:3.10-management 
docker ps -l
```  

- ▶️ Run

```bash
python3 start_sender.py
python3 start_receiver.py

```

## Basic commands

```shell
help - help
chat - chat
task - task
tool - tool list
bind - bind optional platforms
unbind - unbind optional platforms
clear - Delete your own records
rset_endpoint - customize the backend
rset_key - set openai
clear_rset - wipe custom settings

```

## 💻 How to develop?

For plugin development, please refer to the sample plugins in the `plugins` directory.

## 🤝 How can I contribute?

Feel free to submit a Pull Request, we'd love to receive your contribution! Please make sure your code conforms to our
code specification and include a detailed description. Thank you for your support and contribution! 😊😊