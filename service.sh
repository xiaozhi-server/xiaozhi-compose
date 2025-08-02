#!/bin/bash

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

function help() {
  echo "Usage: $0 {start|stop|restart|status|logs}"
  echo "start    - Start the service"
  echo "stop     - Stop the service"
  echo "restart  - Restart the service"
  echo "status   - Check the service status"
  echo "logs     - View the service logs"
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
  *)
    help
    ;;
esac
