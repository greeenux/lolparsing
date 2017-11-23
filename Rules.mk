compile:
	@for dir in $(SUBDIRS); do \
	make -C $$dir || exit $?; \
	done
compile1:
	@for dir in $(TOPDIRS); do \
	make -c ; \
	done
clean:
	@for dir in $(SUBDIRS); do \
	make -C $$dir clean; \
	done
	rm -rf *.o *.i *.S *.a $(TARGET)
