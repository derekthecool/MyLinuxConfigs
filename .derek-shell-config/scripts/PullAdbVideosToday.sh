#!/bin/bash

videoList=$(/mnt/c/WINDOWS/adb.exe shell "find /sdcard/DCIM/Camera/ ~/storage/*/DCIM/Camera/ -name $(date +"%Y%m%d")*.mp4")
echo "$videoList"

for video in $videoList; do
	echo "Pulling video $video"
	powershell.exe -NoProfile adb pull "$video"
done
