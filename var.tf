#Demo NSG
variable "Demo_nsg" {
     description = "NSG creation For Demo"
     type = string
}

/*variable "subnets" {
     description = "Subnet names and prefixes"
     type = map(object({
                    name = string
                    cidr = string
               }))
     default = {
          Subnet1 = {
               name = "default"
               cidr = "10.0.0.0/24"
          }
          Subnet2 = {
               name = "sub01"
               cidr = "10.0.1.0/24"
          }
     }
}*/

variable "subnets" {
     description = "Subnet names and prefixes"
     type = list
     default = [
          {
               name = "default"
               cidr = "10.0.0.0/24"
          },
          {
               name = "sub01"
               cidr = "10.0.1.0/24"
          }
     ]
}

# https://github.com/Azure/terraform-azurerm-network/blob/master/variables.tf

variable "nsg_ids" {
     description = "A map of subnet name to Network Security Group IDs"
     type        = map(string)
     default = {
          Subnet1 = "nsg"
          Subnet2 = "nsg"
     }
}