#!/usr/bin/env bash

# shellcheck disable=SC2015,2034,2154
# 版本、初始化变量
"""
cron: 0 6 * * *
new Env('🔮米游社签到');
"""
VERSION="1.1.1"
TITLE="🔮米游社签到  v${VERSION}"
log_text=""
BRANCH="master"
MCR_PATH="${PWD}"

claimer_path="${MCR_PATH}/genshin-checkin-helper"
[ ! -d "${claimer_path}" ] && cd "${MCR_PATH}" && git clone https://gitlab.com/y1ndan/genshin-checkin-helper && cd "${claimer_path}"

if [ -n "$(ls -A "${claimer_path}")" ]; then
    cd "${claimer_path}" || exit 1
    LOCAL=$(git log $BRANCH -n 1 --pretty=format:"%H")
    REMOTE=$(git log remotes/origin/$BRANCH -n 1 --pretty=format:"%H")
    if [ ! "$LOCAL" = "$REMOTE" ]; then
        echo "开始更新本地仓库..." && git pull || echo "开始硬更新远程仓库到本地!!!" && git checkout $BRANCH && git fetch --all && git reset --hard origin/$BRANCH && git pull
    fi
else
    echo "${claimer_path} 为空，可能为 Git 仓库拉取失败，请检查" && exit 1
fi

[ ! -f "${claimer_path}/config/config.json" ] && echo "没有检测到 ${claimer_path}/config/config.json 文件，请配置" && exit 1

cd "${claimer_path}"
echo "安装依赖" &&  pip install -r requirements.txt
echo -e "${TITLE}"
result_log_text=$(python main.py)
echo -e "${result_log_text}"
