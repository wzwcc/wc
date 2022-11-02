#!/bin/bash
# alpine linux
# 2022年11月2日
# 更新
$dir=pwd
apk update
apk upgrade
# 安装并运行redis
apk add --no-cache redis
redis-server --save 900 1 --save 300 10 --daemonize yes


# 安装chrome
apk add chromium
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
# 安装中文字体
apk add fontconfig 
apk add mkfontscale
mkdir /usr/share/fonts/
cd /usr/share/fonts/

wget https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/TTF/Subset/SourceHanSansCN-VF.ttf

mkfontscale && mkfontdir
cd $dir
git clone --depth=1 -b main https://github.com/Le-niao/Yunzai-Bot.git
cd Yunzai-Bot
pnpm install -P
echo '安装完成';
