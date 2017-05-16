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

all: openconfig-catalog-types.fxs ietf-yang-library.fxs ietf-yang-types.fxs ietf-inet-types.fxs ietf-yang-catalog.fxs openconfig-extensions.fxs openconfig-feature-bundle.fxs openconfig-module-catalog.fxs openconfig-release-bundle.fxs ietf-module-catalog-extensions.fxs ieee-module-catalog-extensions.fxs $(CDB_DIR) ssh-keydir
	cp yangcatalog_*_init.xml $(CDB_DIR)/
	@echo "Build complete"

clean:	iclean

start:  stop start_confd

start_foreground: stop start_confd_foreground

start_confd:
	$(CONFD) -c confd.conf $(CONFD_FLAGS)

start_confd_foreground:
	$(CONFD) -c confd.conf --foreground -v $(CONFD_FLAGS)

stop:
	$(CONFD) --stop    || true
