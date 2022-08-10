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
### Output
**TODO**

