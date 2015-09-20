CURDIR ?= $(.CURDIR)

LN_FLAGS = -sfn

all: install_home

install_home:
	for file in home/*; do ln $(LN_FLAGS) $(CURDIR)/$$file ~/.`basename .$$file`; done
