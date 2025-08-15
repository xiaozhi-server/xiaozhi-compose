#!/bin/bash

export DOCKER_DEFAULT_PLATFORM=linux/amd64
function start() {
  # 启动 docker-compose
  docker-compose up -d
  echo "Starting..."
}

function stop() {
  # 停止 docker-compose
  docker-compose down
  echo "Stopping..."
}

function restart() {
  stop
  start
  echo "Restarting..."
}

function status() {
  # 查看 docker-compose 状态
  docker-compose ps
  echo "Status..."
}

function logs() {
  # 查看 docker-compose 日志
  docker-compose logs -f
  echo "Logs..."
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
  echo "Usage: $0 {start|stop|restart|status|logs}"
  echo "start    - Start the service"
  echo "stop     - Stop the service"
  echo "restart  - Restart the service"
  echo "status   - Check the service status"
  echo "logs     - View the service logs"
  echo "stopXiaozhi - Stop the xiaozhi-backend-go-server service"
  echo "startXiaozhi - Start the xiaozhi-backend-go-server service"
}

case $1 in
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
