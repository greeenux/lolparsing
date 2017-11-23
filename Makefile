.EXPORT_ALL_VARIABLES:

TARGET	:= lol
TOPDIR	:= $(shell /bin/pwd)
SUBDIRS := object array value serialization parser various
include $(TOPDIR)/Config.mk

all: test_file.o libparsing.a
	$(CC) $(CLFAGS) -o $(TARGET) test_file.o -L./ -lparsing

test_file.o: $(TOPDIR)/main/main.c
	gcc -c $^ -I$(TOPDIR)/include 
	cp $(TOPDIR)/main.o $(TOPDIR)/$@

libparsing.a : compile $(OBJS)
	$(AR) $(AR_ADDING_FLAGS) $@ $(addprefix $(TOPDIR)/,$(addsuffix /libmy.a,$(SUBDIRS)))
	
include $(TOPDIR)/Rules.mk
