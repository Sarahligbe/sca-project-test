resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name}PublicIp"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  lifecycle {
      ignore_changes = [
          tags
      ]
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}Nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.name}Nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "Configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id

  depends_on = [azurerm_network_security_group.nsg]
}

resource "azurerm_user_assigned_identity" "vm_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  name = "${var.name}Identity"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.os_disk_size
  admin_username      = var.vm_user
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.vm_user
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "${var.name}OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os_disk_image["publisher"]
    offer     = var.os_disk_image["offer"]
    sku       = var.os_disk_image["sku"]
    version   = var.os_disk_image["version"]
  }

#To be able to login to Azure CLI non-interactively
  identity {
    type = "UserAssigned"
    identity_ids = tolist([azurerm_user_assigned_identity.vm_identity.id])
  }

  depends_on = [
    azurerm_network_interface.nic,
    azurerm_network_security_group.nsg
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "hublink" {
  name                  = "hubvnetlink"
  resource_group_name   = var.dns_resource_group_name
  private_dns_zone_name = var.dns_zone_name
  virtual_network_id    = var.vnet_id
}
