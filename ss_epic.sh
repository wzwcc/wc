#!/usr/bin/env bash

# shellcheck disable=SC2015,2034,2154

source "$(dirname "$0")/utils_env.sh"
source "$(dirname "$0")/notify.sh"
check_env
source_config
get_some_path

# 版本、初始化变量
VERSION="1.1.1"
TITLE="🔮Epicgames v${VERSION}"
log_text=""
PUSH_TMP_PATH="./.ss-epic.tmp"
BRANCH="master"
MCR_PATH="${PWD}"

claimer_path="${MCR_PATH}/epicgames-freebies-claimer"
[ ! -d "${claimer_path}" ] && cd "${MCR_PATH}" && git clone https://github.com/Revadike/epicgames-freebies-claimer && cd "${claimer_path}" && npm install

if [ -n "$(ls -A "${claimer_path}")" ]; then
    cd "${claimer_path}" || exit 1
    LOCAL=$(git log $BRANCH -n 1 --pretty=format:"%H")
    REMOTE=$(git log remotes/origin/$BRANCH -n 1 --pretty=format:"%H")
    if [ ! "$LOCAL" = "$REMOTE" ]; then
        echo "开始更新本地仓库..." && git pull || echo "开始硬更新远程仓库到本地!!!" && git checkout $BRANCH && git fetch --all && git reset --hard origin/$BRANCH && git pull && npm install
    fi
else
    echo "${claimer_path} 为空，可能为 Git 仓库拉取失败，请检查" && exit 1
fi

[ ! -f "${claimer_path}/data/device_auths.json" ] && echo "没有检测到 ${claimer_path}/data/device_auths.json 文件，请配置" && exit 1

echo -e "${TITLE}"
result_log_text=$(node "${claimer_path}"/claimer.js | sed 's/[a-zA-Z0-9_-]\+@/🙈🙈🙈@/g')

if [ "${IS_DISPLAY_CONTEXT}" == 1 ]; then
    echo -e "${result_log_text}"
else
    echo -e "\nHidden the logs, please view notify messages."
fi

log_text="\n\n${result_log_text}"

send_message

rm -rf ${PUSH_TMP_PATH}
