# makefile for libpng using gcc (generic, static library)
# Copyright (C) 2008, 2014 Glenn Randers-Pehrson
# Copyright (C) 2000 Cosmin Truta
# Copyright (C) 1995 Guy Eric Schalnat, Group 42, Inc.
#
# This code is released under the libpng license.
# For conditions of distribution and use, see the disclaimer
# and license in png.h

# Location of the zlib library and include files
#ZLIBINC = ../zlib #フォルダ構成が違うので変更
#ZLIBINC = ../zlib/include
#ZLIBLIB = ../zlib
ZLIBINC = .
ZLIBLIB = B:/LIB

CC = gcc
LD = $(CC)
AR_RC = ar
# AR_RC = lib -m 65534
RM = rm -f
# RM = del /f /q

CPPFLAGS = -I$(ZLIBINC) # -DPNG_DEBUG=5
# CFLAGS =  -W -Wall -cpp-stack=8192000 -z-stack=65536 -DPNG_NO_PEDANTIC_WARNINGS
CFLAGS =  -W -Wall -fall-jsr -O -cpp-stack=4096000 -z-stack=65536 -DPNG_NO_PEDANTIC_WARNINGS -DGCC_MARIKO
LDFLAGS =
#LIBS = -lz
LIBS = $(ZLIBLIB)/libz.a $(ZLIBLIB)/FLOATFNC.L

LIBPNG = libpng.a

# File extensions
#EXEEXT = # X68000なので拡張子変更
EXEEXT = .x

# 下の方のpnglibconf.hルール削除に伴い誰も使わない定義を削除
# Pre-built configuration
# See scripts/pnglibconf.mak for more options
#PNGLIBCONF_H_PREBUILT = scripts/pnglibconf.h.prebuilt

# Variables
OBJS =  png.o pngerror.o pngget.o pngmem.o pngpread.o \
	pngread.o pngrio.o pngrtran.o pngrutil.o pngset.o \
	pngtrans.o pngwio.o pngwrite.o pngwtran.o pngwutil.o

# Targets
all: $(LIBPNG) pngtest$(EXEEXT)

.c.o:
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(LIBPNG): $(OBJS)
	$(AR_RC) $@ $(OBJS)

test: pngtest$(EXEEXT)
	pngtest$(EXEEXT)

pngtest$(EXEEXT): pngtest.o $(LIBPNG)
	$(LD) $(LDFLAGS) -o $@ pngtest.o $(LIBPNG) $(LIBS)

.PHONY: clean

clean:
	-$(RM) *.o
	-$(RM) $(LIBPNG)
	-$(RM) pngtest$(EXEEXT) pngout.png
	-$(RM) pngout.png

png.o:      png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngerror.o: png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngget.o:   png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngmem.o:   png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngpread.o: png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngread.o:  png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngrio.o:   png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngrtran.o: png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngrutil.o: png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngset.o:   png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngtrans.o: png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngwio.o:   png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngwrite.o: png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngwtran.o: png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h
pngwutil.o: png.h pngconf.h pnglibconf.h pngpriv.h pngstruct.h pnginfo.h pngdebug.h

pngtest.o:  png.h pngconf.h pnglibconf.h
