#!/bin/sh
az group create --name yanam --location centralindia
az network vnet create --name vnet1 --resource-group yanam --address-prefixes 172.16.0.0/16 --location centralindia
az network vnet subnet create --name data --address-prefixes 172.16.0.0/24  --resource-group yanam --vnet-name vnet1
az network vnet subnet create --name app --address-prefixes 172.16.1.0/24  --resource-group yanam --vnet-name vnet1
az network vnet subnet create --name web --address-prefixes 172.16.2.0/24  --resource-group yanam --vnet-name vnet1

az network nsg create --name NSG1 --resource-group yanam --location centralindia
az network nsg rule create --name openinbound --nsg-name NSG1 --priority 320 --resource-group yanam --access Allow --source-address-prefixes '*' --destination-address-prefixes '*' --destination-port-ranges 8080 --protocol '*'

az vm create --name VMnsg --resource-group yanam --location centralindia --admin-username madhu --admin-password Adminadmin@123 --nsg NSG1 --image ubuntults --vnet-name vent1 --vnet-address-prefix 172.16.0.0/16 --subnet data --subnet-address-prefix 172.16.0.0/24 --public-ip-sku Basic
