.EXPORT_ALL_VARIABLES:

TARGET	:= lol
TOPDIR	:= $(shell /bin/pwd)
SUBDIRS := object object_api array array_api value value_api serialization parser parser_api various main

include $(TOPDIR)/Config.mk

all: compile $(OBJS)
	$(CC) $(OBJS) $(addsuffix /built-in.o,$(SUBDIRS)) -o $(TARGET)

include $(TOPDIR)/Rules.mk
