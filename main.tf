provider "azurerm" {
    features {}
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    subscription_id = "${var.subscription_id}"
    tenant_id       = "${var.tenant_id}"
}

data "azurerm_resource_group" "main" {
    name     = "Azuredevops"
}

resource "azurerm_virtual_network" "main" {
    name                    = "${var.prefix}-network"
    address_space           = ["10.0.0.0/22"]
    location                = azurerm_resource_group.main.location
    resource_group_name     = azurerm_resource_group.main.name
    tags = {
        project: "udacityP1"
    }
}

// Virtual network
resource "azurerm_network_interface" "main" {
    name                    = "${var.prefix}-network"
    address_space       = ["10.0.0.0/22"]
    location            = data.azurerm_resource_group.main.location
    resource_group_name = data.azurerm_resource_group.main.name  
    tags = {
        project: "udacityP1"
    }
}

// Internal subnet for the upper vnet
resource "azurerm_subnet" "internal" {
    name                    = "${var.prefix}-internal"
    resource_group_name     = data.azurerm_resource_group.main.name
    virtual_network_name    = azurerm_virtual_network.main.name
    address_prefixes        = ["10.0.2.0/24"]
}

// Network security group
resource "azurerm_network_security_group" "main" {
    name                    = "${var.prefix}-security-group"
    location                = azurerm_resource_group.main.location
    resource_group_name     = azurerm_resource_group.main.name
    tags = {
        project: "udacityP1"
    }
}

// Allow only acces to VMs on the same subnet
resource "azurerm_network_security_rule" "rule1" {
    name                       = "inboundAccessSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "*"
    description                = "description-ssh"
    resource_group_name         = data.azurerm_resource_group.main.name
    network_security_group_name = azurerm_network_security_group.main.name
}

// Deny all access from the internet
resource "azurerm_network_security_rule" "rule2" {
    name                       = "DenyAllInbound"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.0/24"  
    resource_group_name         = data.azurerm_resource_group.main.name
    network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_public_ip" "main" {
    name                = "${var.prefix}_public_ip"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    allocation_method   = "Dynamic"

    tags = {
        "tagName" = "webserver"
    }
}


resource "azurerm_lb" "main" {
    name                = "${var.prefix}_Load_Balancer"
    location            = "East US"
    resource_group_name = azurerm_resource_group.main.name

    frontend_ip_configuration {
        name                 = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.main.id
    }

    tags = {
        "tagName" = "webserver"
    }
}


resource "azurerm_lb_backend_address_pool" "main" {
    loadbalancer_id = azurerm_lb.main.id
    name            = "${var.prefix}_BackEnd_AddressPool"
}


resource "azurerm_network_interface_backend_address_pool_association" "main" {
    network_interface_id    = azurerm_network_interface.main.id
    ip_configuration_name   = "${var.prefix}_ip_configuration"
    backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
    }

resource "azurerm_availability_set" "main" {
    name                = "${var.prefix}-availability-set"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    tags = {
        "tagName" = "webserver"
        }
    }


resource "azurerm_linux_virtual_machine" "main" {
    count                           = var.num_vms                          # Number of VMs to be created       
    name                            = "${var.prefix}-VM-00-${count.index}" # Tracks  count for different vm creation
    resource_group_name             = azurerm_resource_group.main.name
    location                        = azurerm_resource_group.main.location
    size                            = "Standard_D2s_v3"
    admin_username                  = var.username
    admin_password                  = var.password
    disable_password_authentication = false
    network_interface_ids = [azurerm_network_interface.main.id]


    os_disk {
        storage_account_type = "Standard_LRS"
        caching              = "ReadWrite"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    tags = {
        "tagName" = "webserver"
    }
}


resource "azurerm_managed_disk" "main" {
    count                = var.num_managed_disks
    name                 = "${var.prefix}-managed-disk-00-${count.index}"
    location             = azurerm_resource_group.main.location
    resource_group_name  = azurerm_resource_group.main.name
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "1"

    tags = {
        "tagName" = "webserver"
    }
}