#!/usr/bin/env bash

wallpaperDir="$HOME/personal/wallpapers"
wallpaper=$(ls ${wallpaperDir} | fzf --preview="feh --bg-fill $wallpaperDir/{}")
feh --bg-fill $wallpaperDir/$wallpaper
