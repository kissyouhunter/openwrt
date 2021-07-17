#!/bin/bash
# matrix.target=${Modelfile}

################################################################################################################
# 获取CPU信息
################################################################################################################
Diy_chuli() {

cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c > CPU
cat /proc/cpuinfo | grep "cpu cores" | uniq >> CPU
sed -i 's|[[:space:]]||g; s|^.||' CPU && sed -i 's|CPU||g; s|pucores:||' CPU
CPUNAME="$(awk 'NR==1' CPU)" && CPUCORES="$(awk 'NR==2' CPU)"
rm -rf CPU

}

################################################################################################################
# 显示cpu信息
################################################################################################################
Diy_xinxi_Base() {
echo
TIME z " 系统空间      类型   容量  已用  可用 使用率"
cd ../ && df -hT $PWD && cd openwrt
echo
TIME z "  本编译 服务器的 CPU型号为 [ ${CPUNAME} ]"
echo
TIME z "  使用 核心数 为 [ ${CPUCORES} ], 线程数为 [ $(nproc) ]"
echo
TIME z "  经过几次测试,随机分配到 E5系列CPU 编译是最慢的,8171M 的CPU快很多，8272CL 的又比 8171M 快一些！"
echo
TIME z "  如果你编译的插件较多，而你又分配到E5系列CPU的话，你可以考虑关闭了重新再来的！"
echo
TIME z "  下面将使用 [ $(nproc) 线程 ] 编译固件"
}
