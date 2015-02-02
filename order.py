#!/usr/bin/env python

import os, re, sys

path = sys.argv[1]
infofile = sys.argv[2]

pattern = 'TINFO:\d*,16,0,"(\\d*)\\..*?".*?TINFO:\d*,27,0,"((.*?)_t(\\d*)\\.mkv)"'
nocollide = '.nocollide'

info = None
with open(infofile, 'r') as f:
	info = f.read().replace('\n', ' ')

if info != None:
	matches = re.findall(pattern, info)
	
	if len(matches) > 0:
		i = 0
		files = []

		matches = sorted(matches)
		for (filenumber, filename, title, titlenumber) in matches:
			source = '%s/%s' % (path, filename)
			dest = '%s/%s_t%s.mkv%s' % (path, title, str(i).zfill(2), nocollide)

			print '%s > %s (%s)' % (source, dest, filenumber)
			os.rename(source, dest)
			files.append(dest)
			
			i = i + 1

		print

		for f in files:
			dest = f.replace(nocollide, '')
			print '%s > %s' % (f, dest)
			os.rename(f, dest)
