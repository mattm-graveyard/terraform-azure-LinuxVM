resource "azurerm_virtual_network" "myvnet" {
  name = var.virtual_network_name
  address_space = [ "10.0.0.0/16" ]
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_subnet" "mysubnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "publicip" {
   depends_on = [                           #For smoother construction 
    azurerm_virtual_network.myvnet,
    azurerm_subnet.mysubnet
  ]
  for_each = var.environment                                  #Creation of a public IP for each environment
  name                = "${var.public_ip_name}-${each.key}"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "Static"
  domain_name_label = "${var.domain_label_name}-${each.key}-${random_string.myrandom.id}"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_network_interface" "mynic" {
  for_each = var.environment                                                #Creation of a network interface for each environment
  name                = "${var.network_interface_name}-${each.key}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicip[each.key].id
  }
}


