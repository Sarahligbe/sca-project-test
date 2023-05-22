## Deployed a 3-tier application to a private Azure Kubernetes Service Cluster

Access the project [here](http://sca-project.uksouth.cloudapp.azure.com/)

- The source code and Dockerfiles can be found in the source-code directory. It was built with React, Node.js and Postgres

- The infrastructure directory contains the Terraform script for provisioning the infrastructure. 

- The infrastructure-addons directory contains an Ansible playbook to configure resources for the cluster. 

- The terraform-backend contains terraform scripts to configure a backend to store the terraform state files.


The project contains the following:
- Two Virtual networks that communicate with each other via Vnet peering
- A firewall and a virtual machine in the hub network. The firewall monitors incoming and outgoing traffic based on the DNAT, Network and Application rules defined. The virtual machine is used to access the private cluster and run commands on it.
- An internal ingress controller. The firewall sends the traffic to the ingress controller which in turn routes the traffic to the different services in the cluster.
- Azure key vault and Ansible vault are used for secrets management.
- Log analytics workspace is used to collect metrics and logs from the resources provisioned in the cluster.
- A GitHub Actions CI/CD pipeline to automate the building, provisioning and deployment of the project 

