# 快速开始 | Quick Start

## 快速模式：一键式启动
### 配置环境变量
```bash
cp env.example .env
```
.env文件中修改为自己的LLM配置
```bash
OPENAI_API_KEY=your_openai_api_key
OPENAI_BASE_URL=https://api.openai.com/v1
```

### 启动服务
```bash
bash service.sh restart
```


## 高级模式：自定义配置
### 配置依赖服务-长记忆模型
文件：conf/memobase-config.yaml 
配置其中
```yaml
llm_base_url: "https://dashscope.aliyuncs.com/compatible-mode/v1"
llm_api_key: "example"
best_llm_model: "qwen2.5-72b-instruct"
```

### 配置依赖服务-音乐服务
将音乐服务代码放在music目录下即可


### 配置xiaozhi服务端
文件：config/config.json
配置其中的llm章节
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

### 启动服务
```bash
bash service.sh restart
```
