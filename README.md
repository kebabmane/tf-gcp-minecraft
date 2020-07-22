# tf-gcp-minecraft
because you need a Minecraft server on GCP

So I needed a self hosted minecraft realm for kids and myself to use and thought I would try out GCP, this is a basic repo that will

- Create the VPC and basic networking configuration required
- Create all the firewalling required to go with the public IP
- SSH in and do some "stuff"
- Patch the instance
- Get minecraft running!

# what resources do we consume in GCP?

So far it's just 1 instance (feel free to change the instance type in the vars) and 1 attached disk - in the future we will also use functions and snapshot backups so we can do point in time backup/restores

I would expect this to cost around $10 USD per month, and if you have access to the GCP $400 in free credits well then it's all free

## Pre Reqs

- install terraform, we use it for base provisionsing
- ensure you have the gcloud cli installed and configured
- 

`From the service account key page in the Cloud Console choose an existing account, or create a new one. Next, download the JSON key file. Name it something you can remember, and store it somewhere secure on your machine.`

Once the file is downloaded you need to set an env var to use it

`export GOOGLE_APPLICATION_CREDENTIALS={{path}}`

## Terraform

- terraform init 
- terraform plan 
- terraform apply

# TODO

[] make sure that when downloading the minecraft jar we always get the latest, it's hard coded right now
[] setup the functions to start, stop, backup and request public IP 
[] allow for association of a domain to the public ip address to make it easier to connect (rather then through IP)