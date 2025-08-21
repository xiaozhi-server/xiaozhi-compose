@echo off
setlocal enabledelayedexpansion

REM 默认 compose 文件
REM default_compose_file=docker-compose.yaml
set default_compose_file=docker-compose.yaml
set COMPOSE_FILE=%default_compose_file%
set CMD=

REM 如果没有参数，进入交互式引导
if "%~1"=="" (
    echo 未检测到参数，请选择要执行的操作:
    echo.
    echo 1. 启动服务 (Start)
    echo 2. 停止服务 (Stop)
    echo 3. 重启服务 (Restart)
    echo 4. 查看服务状态 (Status)
    echo 5. 查看服务日志 (Logs)
    echo 6. 停止 xiaozhi-backend-go-server
    echo 7. 启动 xiaozhi-backend-go-server
    echo 8. 帮助 (Help)
    echo.
    echo 请输入对应数字 [1-8] 后回车：
    set /p choice=Your choice:
    if "%choice%"=="1" set CMD=start
    if "%choice%"=="2" set CMD=stop
    if "%choice%"=="3" set CMD=restart
    if "%choice%"=="4" set CMD=status
    if "%choice%"=="5" set CMD=logs
    if "%choice%"=="6" set CMD=stopXiaozhi
    if "%choice%"=="7" set CMD=startXiaozhi
    if "%choice%"=="8" set CMD=help
    echo.
    echo 请选择 compose 文件:
    echo 1. docker-compose-all.yaml （包含全部服务）
    echo 2. docker-compose.yaml （常用服务）
    echo 请输入对应数字 [1-2] 后回车，默认1：
    set /p cfchoice=Your choice:
    if "%cfchoice%"=="2" set COMPOSE_FILE=docker-compose.yaml
    if "%cfchoice%"=="1" set COMPOSE_FILE=docker-compose-all.yaml
)

REM 解析参数
:parse_args
if "%1"=="" goto after_parse
if "%1"=="-f" (
    set COMPOSE_FILE=%2
    shift
    shift
    goto parse_args
)
if "%1"=="--file" (
    set COMPOSE_FILE=%2
    shift
    shift
    goto parse_args
)
if "%1"=="start" set CMD=start
if "%1"=="stop" set CMD=stop
if "%1"=="restart" set CMD=restart
if "%1"=="status" set CMD=status
if "%1"=="logs" set CMD=logs
if "%1"=="stopXiaozhi" set CMD=stopXiaozhi
if "%1"=="startXiaozhi" set CMD=startXiaozhi
if "%1"=="help" set CMD=help
shift
goto parse_args

after_parse:

REM 检查 .env 文件是否存在，不存在则从 env.example 复制并提醒用户
if not exist .env (
    copy env.example .env >nul
    echo .env file not found. Copied env.example to .env. Please review and modify .env as needed.
)

if "%CMD%"=="start" goto do_start
if "%CMD%"=="stop" goto do_stop
if "%CMD%"=="restart" goto do_restart
if "%CMD%"=="status" goto do_status
if "%CMD%"=="logs" goto do_logs
if "%CMD%"=="stopXiaozhi" goto do_stopXiaozhi
if "%CMD%"=="startXiaozhi" goto do_startXiaozhi
if "%CMD%"=="help" goto do_help

goto do_help

do_start:
    docker-compose -f %COMPOSE_FILE% up --pull always -d
    echo Starting with %COMPOSE_FILE%...
    goto :eof

do_stop:
    docker-compose -f %COMPOSE_FILE% down
    echo Stopping with %COMPOSE_FILE%...
    goto :eof

do_restart:
    call "%~f0" -f %COMPOSE_FILE% stop
    call "%~f0" -f %COMPOSE_FILE% start
    echo Restarting with %COMPOSE_FILE%...
    goto :eof

do_status:
    docker-compose -f %COMPOSE_FILE% ps
    echo Status with %COMPOSE_FILE%...
    goto :eof

do_logs:
    docker-compose -f %COMPOSE_FILE% logs -f
    echo Logs with %COMPOSE_FILE%...
    goto :eof

do_stopXiaozhi:
    docker stop xiaozhi-backend-go-server
    echo Stopping xiaozhi-backend-go-server...
    goto :eof

do_startXiaozhi:
    docker start xiaozhi-backend-go-server
    echo Starting xiaozhi-backend-go-server...
    goto :eof

do_help:
    echo Usage: service.bat [-f compose-file] {start^|stop^|restart^|status^|logs}
    echo   -f, --file   Specify docker compose file ^(default: docker-compose-all.yaml^)
    echo start        - Start the service
    echo stop         - Stop the service
    echo restart      - Restart the service
    echo status       - Check the service status
    echo logs         - View the service logs
    echo stopXiaozhi  - Stop the xiaozhi-backend-go-server service
    echo startXiaozhi - Start the xiaozhi-backend-go-server service
    goto :eof
