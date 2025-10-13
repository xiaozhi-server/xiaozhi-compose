# 快速开始 | Quick Start

## 快速模式：一键部署

### 1. 准备环境变量
```bash
cp env.example .env
```

在 `.env` 中填写自己的云端模型配置（示例为 OpenAI 兼容接口）：
```bash
OPENAI_API_KEY=your_openai_api_key
OPENAI_BASE_URL=https://api.openai.com/v1
```

若需要启动 Web CLI，再补充以下可选项，或保持默认值：
```bash
WEBCLI_WS_URL=ws://example.localhost:8007/xiaozhi/v1/
WEBCLI_DEVICE_TOKEN=test
WEBCLI_DEVICE_MAC=ba:8f:17:de:94:94
```

### 2. 拉起核心服务
```bash
bash service.sh restart
```
该命令会根据 `docker-compose.yaml` 启动后端、管理端、数据库与 Redis。

### 3. （可选）加上 Web CLI
```bash
bash service.sh -f docker-compose-webcli.yaml restart
```
重新执行后会在同一 Compose Project 下创建 `xiaozhi-web-client` 容器，并通过 host network 直连后台 WebSocket。

## 高级模式：自定义配置

### 配置依赖服务 - 长记忆模型
文件：`conf/memobase-config.yaml`
```yaml
llm_base_url: "https://dashscope.aliyuncs.com/compatible-mode/v1"
llm_api_key: "example"
best_llm_model: "qwen2.5-72b-instruct"
```

### 配置依赖服务 - 音乐服务
将音乐服务代码放在 `music/` 目录下即可由容器挂载访问。

### 配置 xiaozhi 服务端
文件：`config/config.json`，主要调整 `llm` 配置段：
```json
{
  "llm": {
    "provider": "aliyun_qwen",
    "aliyun_qwen": {
      "type": "openai",
      "model_name": "qwen2.5-72b-instruct",
      "base_url": "https://dashscope.aliyuncs.com/compatible-mode/v1",
      "api_key": "你的api key",
      "max_token": 500
    }
  }
}
```

### 重新启动
完成配置后再次执行：
```bash
bash service.sh restart
```
