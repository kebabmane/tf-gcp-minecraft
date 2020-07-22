# tf-gcp-minecraft
because you need a Minecraft server on GCP

So I needed a self hosted minecraft realm for kids and myself to use and thought I would try out GCP, this is a basic repo that will

- Create the VPC and basic networking configuration required
- Create all the firewalling required to go with the public IP
- SSH in and do some "stuff"
- Patch the instance
- Get minecraft running!

## Pre Reqs

- install terraform an
- SSH Keys Locally

## Terraform

- terraform init # ensure the gcp provider is installed
- terraform plan # ensure all the required vars have been setup
- terraform apply # pew pew and lasers, deploy your server

