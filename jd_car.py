# -*- coding: utf-8 -*-
"""
pip3 install telethon pysocks httpx
"""
"""
cron: 5 0 * * 1
new Env('上车');
"""

import os
import time

from telethon import TelegramClient, events, sync

api_id_list = os.environ.get("api_id_list").split(',')  # 输入api_id，一个账号一项
api_hash_list = os.environ.get("api_hash_list").split(',')  # 输入api_hash，一个账号一项

# 东东工厂
jdfactory = os.environ.get("jdfactory")
# 京喜工厂
jxfactory = os.environ.get("jxfactory")
# 东东萌宠
jdpet = os.environ.get("jdpet")
# 种豆得豆
jdplantbean = os.environ.get("jdplantbean")
# 东东农场
jdfruit = os.environ.get("jdfruit")
# 签到领现金
jdcash = os.environ.get("jdcash")
# 闪购盲盒
jdsgmh = os.environ.get("jdsgmh")
# 东东健康
jdhealth = os.environ.get("jdhealth")
# 城城
carnivalcity = os.environ.get("carnivalcity")


for num in range(len(api_id_list)):
    session_name = ["id_" + str(i) for i in api_id_list]
    client = TelegramClient(session_name[num], api_id_list[num], api_hash_list[num])
    client.start()
    # 第一项是机器人ID，第二项是发送的文字
    # 种豆得豆
    if jdplantbean is not None:
        client.send_message("@chriszhuli_bot", "/bean " + jdplantbean)
    # 东东农场
    if jdfruit is not None:
        client.send_message("@chriszhuli_bot", "/farm " + jdfruit)
    # 京喜工厂
    if jxfactory is not None:
        client.send_message("@chriszhuli_bot", "/jxfactory " + jxfactory)
    # 闪购盲盒
    if jdsgmh is not None:
        client.send_message("@chriszhuli_bot", "/sgmh " + jdsgmh)
    # 东东工厂
    if jdfactory is not None:
        client.send_message("@chriszhuli_bot", "/ddfactory " + jdfactory)
    # 东东萌宠
    if jdpet is not None:
        client.send_message("@chriszhuli_bot", "/pet " + jdpet)
    # 东东健康
    if jdhealth is not None:
        client.send_message("@chriszhuli_bot", "/health " + jdhealth)
    # 城城
    if carnivalcity is not None:
        client.send_message("@chriszhuli_bot", "/carnivalcity " + carnivalcity)

    time.sleep(5)  # 延时5秒，等待机器人回应（一般是秒回应，但也有发生阻塞的可能）
    client.send_read_acknowledge("@chriszhuli_bot")  # 将机器人回应设为已读
    print("Done! Session name:", session_name[num])

os._exit(0)
