#!/bin/bash

sourcepath=$1
destpath=$2

preset="AppleTV 3"
quality=25
videoX=1920
videoY=1080
subtitlesInclude="scan,1,2,3,4,5,6"
subtitlesBurn=1
extension="mkv"

for file in $(find $sourcepath -name '*.rip'); do
	destfile=${file##*/}
	destfile="${destfile%.rip}".$extension

	HandBrakeCLI -i $file -o $destpath/$destfile --preset="$preset" -q $quality -X $videoX -Y $videoY --optimize --subtitle $subtitlesInclude --subtitle-burn $subtitlesBurn

	chmod 777 $destpath/$destfile

	rm $file
done
