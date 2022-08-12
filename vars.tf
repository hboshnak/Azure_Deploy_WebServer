variable "prefix" {
    description = "This prefix will be used for all resources"
    default     = "Prj1"
}

variable "location" {
    description = "The Azure Region in which all resources in this example should be created."
    default = "East US" 
}

variable "password" {
    description = "The Azure  resource password"
    default = "azureadmin" 
    sensitive = true
}

variable "username" {
    description = "The Azure username"
    default     = "Pa55w0rd!" 
    sensitive   = true
}

variable "number_of_virtual_machines" {
    type        =  number
    description = "Number of Vitual machines"
    default = 2
}

variable "tenant_id" {
    description = "Udacity Lab tenant ID"
    default = "f958e84a-92b8-439f-a62d-4f45996b6d07"
}

variable "client_id" {  
    description = "Udacity Lab App ID"
    default = "8c50ed4e-4700-4237-81a3-05d0fbf54bf7"
}

variable "client_secret" {  
    description = "Azure secret id"
    default = "R8C8Q~qy7jNnAejXx5X8NsuBrCxWdqEPYY4f1bqo"
}

variable "subscription_id" {  
    description = "Azure subscription id"
    default = "e2c7cd99-c3c5-4a90-9109-02e7d50f8311"
}
