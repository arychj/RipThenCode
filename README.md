# Winkle
Scripts to rip and encode blurays

Usage
=====
1. Run ```./rip.sh $processingdir [$outputdir [$postripencode]]``` to rip the bluray.
 * If $outputdir is specified and $postripencode is set to true, encoding will begin automatically after ripping is complete.
 * Otherwise, will rips to '.rip' files which will be picked up by encode.sh the next time it is run.
2. Run ```./encode.sh $processingdir $outputdir``` to encode the ripped titles (looks for '.rip' and encodes to '.mkv')

**Note**: ```rip.sh``` and ```encode.sh``` are intentionally separated to facility ripping on one machine and encoding on another.

**Note 2**: If you place ```rip.sh``` in your crontab, be aware that it looks for any disk in the drive and does not differentiate between video disks to be ripped and any other type of disk (such as an install disk). It will try to rip it, fail, and then eject it immediately.