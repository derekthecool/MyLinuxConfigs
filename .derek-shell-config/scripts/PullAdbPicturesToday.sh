#!/bin/bash

pictureList=$(/mnt/c/WINDOWS/adb.exe shell "find /sdcard/DCIM/Camera/ ~/storage/*/DCIM/Camera/ -name $(date +"%Y%m%d")*.jpg")
echo "$pictureList"

for video in $pictureList; do
	echo "Pulling image $video"
	powershell.exe -NoProfile adb pull "$video"
done
