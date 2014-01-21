#!/bin/bash 

DEV="SynPS/2 Synaptics TouchPad"

# 引数チェック
if [ $# -lt 1 ]; then
    echo "setpad [on|off|toggle]"
    exit 1
fi

# モード決定
if [ $1 = "on" ]; then
    TOUCHON=1
elif [ $1 = "toggle" ]; then
    TOUCHON=`xinput list "${DEV}" | grep disabled | wc -l`
elif [ $1 = "off" ]; then
    TOUCHON=0
else
    echo "不正なパラメータ: $1"
    exit 1
fi

# モード設定
xinput set-prop "${DEV}" --type=int --format=8 "Device Enabled" $TOUCHON

