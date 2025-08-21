#!/bin/bash

export DOCKER_DEFAULT_PLATFORM=linux/amd64

# 检测应该使用哪个 docker compose 命令
function detect_docker_compose() {
  if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker-compose"
  elif command -v docker &> /dev/null && docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
  else
    echo "Error: Neither docker-compose nor docker compose is installed."
    exit 1
  fi
}

# 调用函数设置正确的命令
detect_docker_compose

# 默认 compose 文件
COMPOSE_FILE="docker-compose-all.yaml"

# 解析 -f 或 --file 参数
while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--file)
      COMPOSE_FILE="$2"
      shift 2
      ;;
    start|stop|restart|status|logs|stopXiaozhi|startXiaozhi|help)
      CMD=$1
      shift
      ;;
    *)
      shift
      ;;
  esac
  # break if both COMPOSE_FILE and CMD are set
  if [[ -n "$COMPOSE_FILE" && -n "$CMD" ]]; then
    break
  fi
  # break if only CMD is set and no -f
  if [[ -z "$COMPOSE_FILE" && -n "$CMD" ]]; then
    break
  fi
  # break if only COMPOSE_FILE is set and no CMD
  if [[ -n "$COMPOSE_FILE" && -z "$CMD" ]]; then
    break
  fi
  # else continue
  continue
  done

# 检查 .env 文件是否存在，不存在则从 env.example 复制并提醒用户
if [ ! -f .env ]; then
  cp env.example .env
  echo ".env file not found. Copied env.example to .env. Please review and modify .env as needed."
fi

function start() {
  # 启动 docker-compose
  $DOCKER_COMPOSE_CMD -f "$COMPOSE_FILE" up -d
  echo "Starting with $COMPOSE_FILE..."
}

function stop() {
  # 停止 docker-compose
  $DOCKER_COMPOSE_CMD -f "$COMPOSE_FILE" down
  echo "Stopping with $COMPOSE_FILE..."
}

function restart() {
  stop
  start
  echo "Restarting with $COMPOSE_FILE..."
}

function status() {
  # 查看 docker-compose 状态
  $DOCKER_COMPOSE_CMD -f "$COMPOSE_FILE" ps
  echo "Status with $COMPOSE_FILE..."
}

function logs() {
  # 查看 docker-compose 日志
  $DOCKER_COMPOSE_CMD -f "$COMPOSE_FILE" logs -f
  echo "Logs with $COMPOSE_FILE..."
}

function stopXiaozhi() {
  # 停止 docker-compose
  docker stop xiaozhi-backend-go-server
  echo "Stopping xiaozhi-backend-go-server..."
}

function startXiaozhi() {
  # 启动 docker-compose
  docker start xiaozhi-backend-go-server
  echo "Starting xiaozhi-backend-go-server..."
}

function help() {
  echo "Usage: $0 [-f compose-file] {start|stop|restart|status|logs}"
  echo "  -f, --file   Specify docker compose file (default: docker-compose.yaml)"
  echo "start        - Start the service"
  echo "stop         - Stop the service"
  echo "restart      - Restart the service"
  echo "status       - Check the service status"
  echo "logs         - View the service logs"
  echo "stopXiaozhi  - Stop the xiaozhi-backend-go-server service"
  echo "startXiaozhi - Start the xiaozhi-backend-go-server service"
}

case $CMD in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  status)
    status
    ;;
  logs)
    logs
    ;;
  stopXiaozhi)
    stopXiaozhi
    ;;
  startXiaozhi)
    startXiaozhi
    ;;
  *)
    help
    ;;
esac