// SPDX-License-Identifier: GPL-2.0-only
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Zengxu Yang");
MODULE_DESCRIPTION("A simple RTL8139 PCI Ethernet driver from scratch.");

// Realtek Vendor ID (0x10ec) and RTL8139 Device ID (0x8139)
static struct pci_device_id rtl8139_pci_tbl[] = {
	{ PCI_DEVICE(0x10ec, 0x8139) },
	{
		0,
	} /* Terminating entry */
};
MODULE_DEVICE_TABLE(pci, rtl8139_pci_tbl);

// Called when the kernel finds an unhandled RTL8139 matching your ID
static int rtl8139_pci_probe(struct pci_dev *pdev,
			     const struct pci_device_id *id)
{
	printk(KERN_INFO "rtl8139: Hardware matched! Initializing...\n");
	// TODO: Enable device, request regions, allocate net_device
	return 0;
}

// Called during rmmod or if the device is hot-unplugged
static void rtl8139_pci_remove(struct pci_dev *pdev)
{
	printk(KERN_INFO "rtl8139: Driver unloaded, releasing resources.\n");
}

// PCI subsystem structure
static struct pci_driver rtl8139_driver = {
	.name = "rtl8139_driver",
	.id_table = rtl8139_pci_tbl,
	.probe = rtl8139_pci_probe,
	.remove = rtl8139_pci_remove,
};

static int __init rtl8139_init(void)
{
	return pci_register_driver(&rtl8139_driver);
}

static void __exit rtl8139_exit(void)
{
	pci_unregister_driver(&rtl8139_driver);
}

module_init(rtl8139_init);
module_exit(rtl8139_exit);
