![cover](https://raw.githubusercontent.com/LLMKira/Docs/main/docs/cover.png)
------------------------------------
<p align="center">
  <img alt="License" src="https://img.shields.io/badge/LICENSE-AGPL-ff69b4">
  <img src="https://img.shields.io/badge/Python-3.8|9|10|11-green" alt="Python" >
  <a href="https://afdian.net/a/Suki1077"><img src="https://img.shields.io/badge/Buyme-milk-DB94A2" alt="SPONSOR"></a>
  <a href="https://app.fossa.com/projects/git%2Bgithub.com%2Fsudoskys%2FOpenaibot?ref=badge_small" alt="FOSSA Status"><img src="https://app.fossa.com/api/projects/git%2Bgithub.com%2Fsudoskys%2FOpenaibot.svg?type=small"/></a>
</p>

<h2 align="center">OpenaiBot</h2>

[ENGLISH](https://github.com/LlmKira/Openaibot/blob/main/README.md)

全平台，多模态(语音/图片)理解，自维护套件，实时信息支持

如果您没有所需的即时消息平台，或者您想开发一个新的应用程序，欢迎您为该仓库贡献。

您可以使用“Event.py”开发新的控制器。

我们使用自维护的 [llm-kira](https://github.com/LLMKira/llm-kira) 实现对话客户端

## 🥽 Feature

* 异步
* 支持聊天速率限制
* 支持私聊、群聊
* 支持黑名单和白名单系统
* 支持使用管理、角色以及自定义行文风格 🤖
* 内存池保证1000轮的上下文内存保存 💾
* 跨平台，还支持本地语音助手 🗣️
* 允许多个Api密钥轮询，便于管理和弹出窗口 📊
* 主动搜索要回复的内容并支持贴纸回复 😊
* 跨平台支持的通用接口，理论上允许访问任何聊天平台 🌐
* 拥有可移除的内容安全组件，也支持官方Api过滤内容 🔒
* 实时网页索引支持，万能爬虫 (支持 UrlQueryHtml url?q={}) 🕸️
* 多模态交互支持，图像Blip理解支持，语音识别 👂 , 贴纸支持 😎

## 🪜 Deploy It

### 🔨 Check

请确保您的服务器有 1GB 的 RAM 和 10GB的 可用存储空间

对于 Arm 架构服务器: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh` (安装脚本现已可以自动安装rust)

### 📦 Deploy/Renew

```shell
curl -LO https://raw.githubusercontent.com/LLMKira/Openaibot/main/setup.sh && sh setup.sh
```
对于中国用户
```shell
curl -LO https://raw.kgithub.com/LLMKira/Openaibot/main/setup.sh && sh setup.sh
```

### 🍽 Configure

- 初始化

```shell
cp Config/app_exp.toml Config/app.toml

nano Config/app.toml
```

- 数据

```shell
apt-get install redis
systemctl enable redis.service --now
```

- 配置/app.toml

```toml
# Comment out which part you don't want to start

# QQ Bot
[Controller.QQ]
master = [114, 514] # master user id
account = 0
http_host = 'http://localhost:8080'   # Mirai http Server
ws_host = 'http://localhost:8080'   # Mirai Websocket Server
verify_key = ""
trigger = false # Proactive response when appropriate
INTRO = "POWER BY OPENAI"  # Suffixes for replies
ABOUT = "Created by github.com/LLMKira/Openaibot" # /about
WHITE = "Group NOT in WHITE list" # Whitelist/Blacklist tips

# Proxy set, but does not proxy openai api, only bot
proxy = { status = false, url = "http://127.0.0.1:7890" }

# Telegram Bot
[Controller.Telegram]
master = [114, 514] # master user id
botToken = '' # Bot Token @botfather
trigger = false
INTRO = "POWER BY OPENAI"
ABOUT = "Created by github.com/LLMKira/Openaibot"
WHITE = "Group NOT in WHITE list"

# 设置的代理，但是不代理 openai api, 只代理 bot
proxy = { status = false, url = "http://127.0.0.1:7890" }

# 基础对话事件服务器，Web支持或者音箱用
[Controller.BaseServer]
host = "127.0.0.1"
port = 9559
```

### 🪶 App Token

- Telegram

[Telegram BotToken Request](https://t.me/BotFather)

请确保 *机器人是组管理员* 或 *隐私模式已关闭*.

- QQ

[Configuring the QQ bot](https://graiax.cn/before/install_mirai.html)

### 🌻 Run Bot

我们的机器人可以多线程运行

```shell
apt install npm
npm install pm2@latest -g
# or
yarn global add pm2

# test bot
python3 main.py

# run bot
pm2 start pm.json
```

### 🎤 Or Run Voice Assistant

除了机器人，我们还有语音助手.

Voice Assistant 是一个依赖于 Web 的语音助手，你可以通过 Azure 或  Openai 的识别服务在小型设备上轻松地运行它

- 运行 `BaseEvent` 服务器

```toml
# 基础对话事件服务器，Web支持或者音箱用
[Controller.BaseServer]
port = 9559
```

- 运行 Vits 服务器

https://github.com/LlmKira/MoeGoe

- 运行助手

```shell
cd Assistant
cat install.md
pip3 install -r requirements.txt
python3 clinet.py
```

### 🥕 Add Api Key

使用 `/add_api_key` 命令将 [OpenaiKey](https://beta.openai.com/account/api-keys) 添加到 `Config/api_keys.json`.

### 🧀 More Docs

[部署文档](https://llmkira.github.io/Docs/en/guide/getting-started)的详细信息

Network Plugins/Proxy Settings/自定义模型名称/语音服务/图片理解/Censor配置请参见
[服务器配置指南](https://llmkira.github.io/Docs/guide/service)

详细接口/服务配置/自定义 请查看文档 [部署指南](https://llmkira.github.io/Docs/guide/getting-started)

插件设置/代理设置/自定义模型名称/语音服务/图片理解/审查配置
请查看 [服务配置](https://llmkira.github.io/Docs/guide/service)

## 🤗 Join Our Community

<a href="https://github.com/LLMKira/Openaibot/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=LLMKira/Openaibot" />
</a>

## ❤ Thanks

- [QuickDev](https://github.com/TelechaBot/BaseBot)
- [LLM Kira](https://github.com/LLMKira/llm-kira)
- [text_analysis_tools](https://github.com/murray-z/text_analysis_tools)
- [MoeGoe Voice](https://github.com/CjangCjengh/MoeGoe)

## 📃 License

```
This project open source and available under
the [AGPL License](https://github.com/LLMKira/Openaibot/blob/main/LICENSE).
```

[CLAUSE](https://github.com/LlmKira/Openaibot/blob/main/CLAUSE.md) 说明了如何授权，声明，附加条款等内容。

### Fossa

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fsudoskys%2FOpenaibot.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fsudoskys%2FOpenaibot?ref=badge_large)

> 你不会相信，但是 Ai 也写了这个 Readme 的一部分
