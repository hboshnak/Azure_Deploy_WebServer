variable "prefix" {
    description = "This prefix will be used for all resources"
    default     = "Prm1"
}

variable "location" {
    description = "The Azure Region in which all resources in this example should be created."
    default = "East US" 
}

variable "password" {
    description = "The Azure resource password"
    default = "Pa55w0rd!" 
    sensitive = true
}

variable "username" {
    description = "The Azure username"
    default     = "azureuser" 
    sensitive   = true
}

variable "number_of_virtual_machines" {
    type        =  number
    description = "Number of Vitual machines"
    default = 2
}

variable "tenant_id" {
    description = "Tenant ID"
    default = "TODO-U-FILL-IT"
}

variable "client_id" {  
    description = "Client ID"
    default = "TODO-U-FILL-IT"
}

variable "client_secret" {  
    description = "Client secret id"
    default = "TODO-U-FILL-IT"
}

variable "subscription_id" {  
    description = "Azure subscription id"
    default = "TODO-U-FILL-IT"
}
