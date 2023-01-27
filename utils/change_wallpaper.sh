#!/usr/bin/env bash

wallpaperDir="$HOME/Pictures/wallpaper"
wallpaper=$(ls ${wallpaperDir} | fzf --preview="feh --bg-fill $wallpaperDir/{}")
feh --bg-fill $wallpaperDir/$wallpaper
