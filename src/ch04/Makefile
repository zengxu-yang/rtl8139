obj-m += rtl8139_driver.o

KDIR := /lib/modules/$(shell uname -r)/build
PWD  := $(shell pwd)

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

lsp:
	$(MAKE) -C $(KDIR) M=$(PWD) V=1 -nw > build.log

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
