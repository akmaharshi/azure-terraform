data "azurerm_resource_group" "Demo_rg1" {
  name = "rg"
  #location = "East US"
}

data "azurerm_virtual_network" "Demo_Vnet" {
    name= "vnet1"
    resource_group_name = data.azurerm_resource_group.Demo_rg1.name
    #location =data.azurerm_resource_group.location
}

output "azurerm_virtual_network" {
    value = "${data.azurerm_virtual_network.Demo_Vnet.*.id}"
}

####################### - 1
/*data "azurerm_subnet" "Demo_subnet" {
  name = "${data.azurerm_virtual_network.Demo_Vnet.subnets[count.index]}"
  virtual_network_name = "${data.azurerm_virtual_network.Demo_Vnet.name}"
  resource_group_name = "${data.azurerm_resource_group.Demo_rg1.name}"
  count = "${length(data.azurerm_virtual_network.Demo_Vnet.subnets)}"
}

output "azurerm_subnet_ids" {
   value = "${data.azurerm_subnet.Demo_subnet.*.id}"
}*/
####################### - 1

data "azurerm_subnet" "test_subnet" {
    name = "${lookup(element(var.subnets, count.index), "name")}"
    count = "${length(var.subnets)}"
    virtual_network_name = "${data.azurerm_virtual_network.Demo_Vnet.name}"
    resource_group_name = "${data.azurerm_resource_group.Demo_rg1.name}"
    #address_prefixes = "${lookup(element(var.subnets, count.index), "cidr")}"
}

output "azurerm_subnet_ids" {
   value = "${data.azurerm_subnet.test_subnet.*.id}"
}

resource "azurerm_network_security_group" "Demo_nsg_test" {
  name                = var.Demo_nsg
  location            = data.azurerm_resource_group.Demo_rg1.location
  resource_group_name = data.azurerm_resource_group.Demo_rg1.name
}

resource "azurerm_subnet_network_security_group_association" "subnet01_nsg_associate" {  
  count = "${length(var.subnets)}"
  subnet_id = data.azurerm_subnet.test_subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.Demo_nsg_test.id
}

resource "azurerm_network_security_rule" "example" {
  name                        = "test123"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.Demo_rg1.name
  network_security_group_name = azurerm_network_security_group.Demo_nsg_test.name
}

/*data "azurerm_subnet" "Demo_subnet" {
  for_each             = var.subnets
  name                 = lookup(each.value, "name")
  resource_group_name  = data.azurerm_resource_group.Demo_rg1.name
  virtual_network_name = data.azurerm_virtual_network.Demo_Vnet.name
  address_prefixes     = lookup(each.value, "cidr")
}

locals {
  azurerm_subnets = {
    for index, subnet in data.azurerm_subnet.Demo_subnet :
      subnet.name => subnet.id
  }
}

output "subnet_ids" {
  value = "${data.azurerm_subnet.Demo_subnet.*.id}"
}*/

####################### - 1

/*resource "azurerm_network_security_group" "Demo_nsg_test" {
  name                = var.Demo_nsg
  location            = data.azurerm_resource_group.Demo_rg1.location
  resource_group_name = data.azurerm_resource_group.Demo_rg1.name
}

resource "azurerm_subnet_network_security_group_association" "subnet01_nsg_associate" {  
  count = "${length(data.azurerm_virtual_network.Demo_Vnet.subnets)}"
  subnet_id = data.azurerm_subnet.Demo_subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.Demo_nsg_test.id
}*/

####################### - 1

# Resource-2: Associate NSG and Subnet
#resource "azurerm_subnet_network_security_group_association" "rg" {
 # for_each                  = var.nsg_ids
 # subnet_id                 = local.azurerm_subnets[each.key]
 # network_security_group_id = each.value
