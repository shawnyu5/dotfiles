#!/bin/bash

echo $head_value
task=$(task active | sed -e '1,3d')
notify-send "$task"

