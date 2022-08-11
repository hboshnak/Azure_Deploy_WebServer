variable "prefix" {
    description = "This prefix will be used for all resources"
    default     = "Azuredevops"
}

variable "tags" {
    description = "Map of the tags to use for the deployed resources"
    type        = map(string)
    default = {
        Name = "udacity-azure-webserver"
  }
}

variable "location" {
    description = "The Azure Region in which all resources in this example should be created."
    default = "East US" 
}


variable "password" {
    description = "The Azure  resource password"
    default = "yourPass" 
    sensitive = true
}

variable "username" {
    description = "The Azure username"
    default     = "yourName" 
    sensitive   = true
}

variable "num_vms" {
    type        =  number
    description = "Number of Vitual machines"
}


variable "num_managed_disks" {
    type        = number
    description = "Number of Managed disks"
}