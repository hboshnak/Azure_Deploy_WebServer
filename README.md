# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction

For this project, we will use a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

The original starter template of this project lives at this [repository](https://github.com/udacity/nd082-Azure-Cloud-DevOps-Starter-Code)

## Getting Started
1. Clone or make a fresh copy of this repository, so you can tweak'n'squeeze it.

2. Follow the instructions

3. Enjoy your new magical abilities

## Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

## Instructions

### 0. Login into Azure CLI using your Azure credentials

```bash
az login
```

### 1. Deploy a Policy

#### 1.1 Create a custom tagging policy definition based on the json configurations:

Navigate to **policy** subdirectory

```bash
az policy definition create --name "TaggingPolicyDef" --description "Deny all not idexed resources" --display-name "Deny if not taggd" --mode "Indexed" --rules ./tag_policy_rules.json
```

#### 1.2 Create a policy assignment:

```bash
az policy assignment create --name "TaggingPolicy" --policy "TaggingPolicyDef" --display-name "Assignment of policy Deny if not tagged" --description "Assignment of denying non tagged indexed resources"
```


#### 1.3 Verify the creation of the policy

```bash
az policy assignment list
```

### 2. Packer image template
In order to support application deployment, we'll need to create an image that different organizations can take advantage of to deploy their own apps! To do this, we'll create a packer image that anyone can use, and we'll leverage in our own Terraform template.

#### 2.1 Create a Server Image
- use the template provided
- use Ubuntu 18.04-LTS as a base image
- modify the provisioners according the requirements
- ensure the resource group names 
in Packer and Terraform  are the same
- assign the proper values to environment variables
- under the **packer** subdirectory build the image by running:

```bash
packer build server.json
```


### Output
**TODO**

