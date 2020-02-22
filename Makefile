GPRBUILD_FLAGS = -p -j0
PREFIX                 ?= /usr
GPRDIR                 ?= $(PREFIX)/share/gpr
LIBDIR                 ?= $(PREFIX)/lib
INSTALL_PROJECT_DIR    ?= $(DESTDIR)$(GPRDIR)
INSTALL_INCLUDE_DIR    ?= $(DESTDIR)$(PREFIX)/include/webdriver
INSTALL_LIBRARY_DIR    ?= $(DESTDIR)$(LIBDIR)
INSTALL_ALI_DIR        ?= ${INSTALL_LIBRARY_DIR}/webdriver

GPRINSTALL_FLAGS = --prefix=$(PREFIX) --sources-subdir=$(INSTALL_INCLUDE_DIR)\
 --lib-subdir=$(INSTALL_ALI_DIR) --project-subdir=$(INSTALL_PROJECT_DIR)\
 --link-lib-subdir=$(INSTALL_LIBRARY_DIR)

SHELL = bash

all:
	gprbuild $(GPRBUILD_FLAGS) -P gnat/webdriver.gpr
	gprbuild $(GPRBUILD_FLAGS) -P gnat/webdriver_ex.gpr

install:
	gprinstall $(GPRINSTALL_FLAGS) -p -P gnat/webdriver.gpr

check: all
	echo No tests here

clean:
	gprclean -q -P gnat/webdriver.gpr
	gprclean -q -P gnat/webdriver_ex.gpr
