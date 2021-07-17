#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.2.4/g' package/base-files/files/bin/config_generate

#修改主机名为N1
sed -i 's/OpenWrt/N1/g' package/base-files/files/bin/config_generate

# 添加旁路由防火墙
echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

#修改build日期
#sed -i "s/R21.6.22/R21.6.22 2021.06.27 powered by kissyouhunter/g" package/lean/default-settings/files/zzz-default-settings
#sed -i "s/Openwrt/N1/g" package/lean/default-settings/files/zzz-default-settings
version=$(grep "DISTRIB_REVISION=" package/lean/default-settings/files/zzz-default-settings  | awk -F "'" '{print $2}')
sed -i '/DISTRIB_REVISION/d' package/lean/default-settings/files/zzz-default-settings
echo "echo \"DISTRIB_REVISION='${version} $(TZ=UTC-8 date "+%Y.%m.%d") powered by kissyouhunter '\" >> /etc/openwrt_release" >> package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/d' package/lean/default-settings/files/zzz-default-settings
echo "exit 0" >> package/lean/default-settings/files/zzz-default-settings

#修改luci-app-adguardhome配置config文件
#sed -i 's'/usr/bin/AdGuardHome'/'usr/bin/AdGuardHome/AdGuardHome'/g' #feeds/kenzok/luci-app-adguardhome/root/etc/config/AdGuardHome

#删除默认密码
#sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

#themes
#git clone https://github.com/Leo-Jo-My/luci-theme-Butterfly package/luci-theme-Butterfly
#git clone https://github.com/Leo-Jo-My/luci-theme-Butterfly-dark package/luci-theme-Butterfly-dark

# 替换adguardhome Makefie
wget -O ./feeds/kiss/AdGuardHome/adguardhome/Makefile https://raw.githubusercontent.com/kissyouhunter/openwrt/main/diy/n1/adguardhome/Makefile

# 替换luci-app-adguardhome AdGuardHome
wget -O ./feeds/kiss/luci-app-adguardhome/root/etc/config/AdGuardHome https://raw.githubusercontent.com/kissyouhunter/openwrt/main/diy/n1/luci-app-adguardhome/AdGuardHome