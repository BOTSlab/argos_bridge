#!/bin/bash
# Launch individual bot control scripts

#bots=$(echo bot{0..29})
bots=$(echo bot{0..0})
echo "Launching the following bots: $bots"

for bot in $bots; do
    ./launch_demo_controller.py $bot &
done

wait
