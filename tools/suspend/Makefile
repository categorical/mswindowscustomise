
#DTHIS:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

FOUT=bin/suspend.exe
FOUT_O=staging/suspend.o

DMSWINDOWS=C:\Program Files (x86)\Windows Kits\10
CC=cl
CFLAGS="-I$(DMSWINDOWS)\Include\10.0.19041.0\um" /std:c++14
LDFLAGS=/link /LIBPATH:"$(DMSWINDOWS)\Lib\10.0.19041.0\um\x86" user32.lib powrprof.lib



build: src/suspend.cpp
	[ -d staging ]||mkdir staging
	[ -d bin ]||mkdir bin
	$(CC) $(CFLAGS) /Fo:$(FOUT_O) /Fe:$(FOUT) $< $(LDFLAGS)



.PHONY:run
.PHONY:clean
clean:
	rm -rf staging
#run:
#	$(DTHIS)/$(FOUT)




