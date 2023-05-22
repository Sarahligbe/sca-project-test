## Deployed a 3-tier application to a private Azure Kubernetes Service Cluster

- The source code and Dockerfiles can be found in the source-code directory. It was built with React, Node.js and Postgres

- The infrastructure directory contains the terraform script for provisioning the infrastructure. 

- The infrastructure-addons directory contains an ansible playbook to configure resources for the cluster. 

- The terraform-backend contains terraform scripts to configure a backend to store the terraform state files.