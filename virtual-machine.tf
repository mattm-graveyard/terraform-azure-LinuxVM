resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  for_each            = azurerm_network_interface.mynic             #Creation of a VM for each network interface 
  name                = "${var.vm_name}${each.key}"
  computer_name       = "${var.computer_name}${each.key}"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.mynic[each.key].id,
  ]

  admin_ssh_key {
    username   = var.ssh_username
    public_key = module.ssh_key.public_key
  }

  os_disk {
    name                 = "${var.os_disk_name}${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "87-gen2"
    version   = "latest"
  }
}