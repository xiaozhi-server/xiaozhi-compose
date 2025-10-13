# xiaozhi-compose

Docker Compose bundles for bootstrapping the xiaozhi 多模态语音服务栈（后端、管理端与可选 Web CLI）。

## 目录说明
- `docker-compose.yaml`：默认后台与管理端（包含 PostgreSQL、Redis）。
- `docker-compose-webcli.yaml`：可选 Web CLI 客户端，默认采用 host network 直连后台。
- 其他 `docker-compose-*.yaml`：语音识别、长记忆等扩展模块，可按需组合。
- `service.sh`：统一的启动脚本，自动适配 `docker compose` 与 `docker-compose`。

## 快速上手
1. 复制并修改环境变量：`cp env.example .env`，在 `.env` 中填写云端 LLM 及（可选）Web CLI 所需配置。
2. 启动核心服务：`bash service.sh restart`。
3. 若需 Web CLI，重新执行：`bash service.sh -f docker-compose-webcli.yaml restart`。

更多细节与手动配置说明见 `quickstart.md`。

## 常用操作
- 查看容器状态：`bash service.sh status`
- 实时日志：`bash service.sh logs`
- 停止服务：`bash service.sh stop`

如需仅启动单个附加模块，可直接调用 `docker compose -f <file> up -d`，但推荐通过 `service.sh` 统一管理，确保 `.env`、网络与卷配置一致。
