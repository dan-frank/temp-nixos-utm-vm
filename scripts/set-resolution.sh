#!/usr/bin/env bash

# For finding Modeline for `xrandr --newmode ...`
# $ gtf 3402 1990 120
# $  # 3400x1990 @ 120.00 Hz (GTF) hsync: 255.84 kHz; pclk: 1221.89 MHz
# $  Modeline "3400x1990_120.00"  1221.89  3400 3704 4088 4776  1990 1991 1994 2132  -HSync +Vsync

xrandr --newmode "3400x1990_120.00"  1221.89  3400 3704 4088 4776  1990 1991 1994 2132  -HSync +Vsync
xrandr --addmode Virtual-1 "3400x1990_120.00"
xrandr --output Virtual-1 --mode "3400x1990_120.00"

