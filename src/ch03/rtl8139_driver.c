#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Zengxu Yang");
MODULE_DESCRIPTION("A simple RTL8139 PCI Ethernet driver from scratch.");

static int __init rtl8139_init(void)
{
	printk(KERN_INFO "rtl8139: Driver module loaded successfully.\n");
	return 0;
}

static void __exit rtl8139_exit(void)
{
	printk(KERN_INFO "rtl8139: Driver module unloaded.\n");
}

module_init(rtl8139_init);
module_exit(rtl8139_exit);
