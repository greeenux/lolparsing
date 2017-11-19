ifndef TOPDIR
TOPDIR	:= ..
endif

include $(TOPDIR)/Config.mk

TARGET	:= built-in.o
SUBDIRS	:=
OBJS	:= $(patsubst %.S, %.o, $(wildcard *.S))
OBJS	+= $(patsubst %.c, %.o, $(wildcard *.c))

all: compile $(OBJS)
	$(LD) -r $(addsuffix /$(TARGET),$(SUBDIRS)) $(OBJS) -o $(TARGET)

include $(TOPDIR)/Rules.mk 
