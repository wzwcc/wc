#!/usr/bin/env bash

# shellcheck disable=SC2015,2034,2154
# 版本、初始化变量
:<<!
cron: 45 8 * * *
new Env('🔮每日签到');
!
dailycheckin --include TIEBA BILIBILI ACFUN CLOUD189
echo "执行完成" 
