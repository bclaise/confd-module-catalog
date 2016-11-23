usage:
	@echo "make all     Build all example files"
	@echo "make clean   Remove all built and intermediary files"
	@echo "make start   Start CONFD daemon and example agent"
	@echo "make stop    Stop any CONFD daemon and example agent"

CONFD_DIR ?= ../../..
include $(CONFD_DIR)/src/confd/build/include.mk

# In case CONFD_DIR is not set (correctly), this rule will trigger
$(CONFD_DIR)/src/confd/build/include.mk:
	@echo 'Where is ConfD installed? Set $$CONFD_DIR to point it out!'
	@echo ''

CONFD_FLAGS = --addloadpath $(CONFD_DIR)/etc/confd 
START_FLAGS ?=

all: openconfig-catalog-types.fxs openconfig-extensions.fxs openconfig-feature-bundle.fxs openconfig-module-catalog.fxs openconfig-release-bundle.fxs ietf-module-catalog-extensions.fxs $(CDB_DIR) ssh-keydir
	cp yangcatalog_init.xml $(CDB_DIR)/aaa_init.xml
	@echo "Build complete"

clean:	iclean

start:  stop start_confd

start_confd:
	$(CONFD) -c confd.conf $(CONFD_FLAGS)

stop:
	$(CONFD) --stop    || true
