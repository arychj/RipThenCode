#!/bin/bash

sourcedrive="/dev/sr0"
outputdir="/tmp/rips"
extension="rip"
minlength=1800
notificationCommand=""

infofile="/tmp/ripinfo.txt"

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ `ls -l /dev/disk/by-label/ | grep sr0 | wc -l` == 1 ]]; then
	dtstart=`date`

	mkdir -p $outputdir

	title=$(blkid -o value -s LABEL $sourcedrive)
	title=${title// /_}

	if [ -n "$notificationCommand" ]; then
		$notificationCommand "$title has started ripping"
	fi

	makemkvcon mkv disc:0 all $outputdir --decrypt --minlength=$minlength

	makemkvcon -r info disc:0 --minlength=$minlength > $infofile
	$dir/order.py $outputdir $infofile
	rm $infofile

	for file in $(find $outputdir -name '*.mkv'); do
		destfile="${file%.mkv}".$extension
		mv $file $destfile
		chmod 777 $destfile
	done

	dtend=`date`

	elapsed=`date -d @$(( $(date -d "$dtend" +%s) - $(date -d "$dtstart" +%s) )) -u +'%H:%M:%S'`

	if [ -n "$notificationCommand" ]; then
		$notificationCommand "$title has finished ripping in $elapsed"
	fi

	eject $sourcedrive
fi
