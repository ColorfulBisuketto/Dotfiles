#! /bin/bash

# from https://github.com/elkowar/eww/issues/230
# or   https://github.com/ankkax/hyprland/blob/main/eww/bar/scripts/cava-internal.sh

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]; do
  dict="${dict}s/$i/${bar:$i:1}/g;"
  i=$((i = i + 1))
done

# make sure to clean pipe
pipe="/tmp/cava.fifo"
if [ -p $pipe ]; then
  unlink $pipe
fi
mkfifo $pipe

printf "[general]\nframerate=60\nbars = 37\nsleep_timer=3\n[output]\nmethod = raw\nraw_target = /dev/stdout\ndata_format = ascii\nascii_max_range = 7\n" | cava -p /dev/stdin | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g; '
