# gcp-gke-project

This is a code repository containing Terraform (TF) code for an organisation in Finland deploying cloud-native applications in Kubernetes clusters. The main requirement for this organization is to have Dev & Prod clusters for blue/green deployments, which are intended for testing and releasing the applications developed by the development team within the organisation. Furthermore, it is required that the organisation has control over Kubernetes release upgrades in GCP, so that the applications deployed in the clusters do not break after automatic upgrade of the Kubernetes control plane. 

This Git repository should not be considered a monorepository. Each main folder is considered a Git repository of its own, where resources defined in the TF repositories can be deployed with CI/CD pipeline tools such as GCP Cloudbuild and GitHub Actions.

The organisation selected GCP Region: Europe-North1 to cater to customers within Finland. The organisation has divided their cloud-native application development into three, namely:

- App1
- App2
- App3

## Folder Structure

The Git folder structure is as follows:

```bash
.
├── README.md
├── gke-project-app1        # TF code for App1-GKE GCP Project
│   ├── app1-bastion.tf
│   ├── app1-gke.tf
│   └── providers.tf
├── gke-project-app2        # TF code for App2-GKE GCP Project
│   ├── app2-bastion.tf
│   ├── app2-gke.tf
│   └── providers.tf
├── gke-project-app3        # TF code for App3-GKE GCP Project
│   ├── app3-bastion.tf
│   ├── app3-gke.tf
│   └── providers.tf
├── governance              # TF code for Governance
│   ├── gcp-iam.tf
│   ├── gcp-import-sources.tf
│   ├── gcp-projects.tf
│   ├── gcp-svc-acc-var.tf
│   ├── gcp-svc-acc.tf
│   ├── gcp-users.tf
│   ├── outputs.tf
│   └── providers.tf
└── networking              # TF code for GCP networking; applies to entire org; split if needed
    ├── networking-nat.tf
    ├── networking-vpc.tf
    ├── outputs.tf
    └── providers.tf

6 directories, 22 files
```

## GCP Project Hierarchy

The project hierarchy for this organisation is as follows:

![GCP Project Hierarchy for the Organisation](https://github.com/mharris-t/gcp-gke-project/blob/main/diagrams/figures/GCP%20Hierarchy.png)

The hierarchy depicted above outlines three primary project folders housing various deployed projects within them. The central project, Governance, serves as the hub for defining and managing users, service accounts, and their scopes within the organization. Additionally, to facilitate cloud automation using Terraform (TF), a Google Cloud Platform (GCP) storage bucket with versioning enabled is deployed for use as the TF backend across the organization. Each repository defines multiple TF backends (providers.tf) with distinct prefixes.

## Cluster Networking

The VPCs hosting the GKE clusters are deployed in App1, App2 and App3 GCP projects. GKE clusters are private clusters and hence, subnets with private IP addresses are deployed in each VPCs. Each VPC has a NAT instance and a NAT router deployed, allowing clusters and bastion host access to the internet for pulling images, access to online update repositories, etc. 

Each App project consists of Dev and Prod clusters. The design for networking is done in a way that VPC in each project can be VPC-peered in the future if required. The subnetting is as follows:

### App1
```bash
Dev Node Subnet       = "10.0.0.0/29" #4 nodes
Dev Pod Subnet        = "10.0.4.0/22" #440 pods / 4 nodes
Dev Services Subnet   = "10.0.0.128/25" #128 services / 4 nodes

Prod Node Subnet      = "10.0.0.16/28" #12 nodes
Prod Pod Subnet       = "10.0.16.0/20" #1760 pods / 16 nodes
Prod Services Subnet  = "10.0.2.0/23"  #512 services / 16 nodes

Bastion Subnet        = "10.0.0.8/29" #4 nodes
```

### App2
```bash
Dev Node Subnet       = "10.0.32.0/29" #4 nodes
Dev Pod Subnet        = "10.0.36.0/22" #440 pods / 4 nodes
Dev Services Subnet   = "10.0.32.128/25" #128 services / 4 nodes
Prod Node Subnet      = "10.0.32.16/28" #12 nodes
Prod Pod Subnet       = "10.0.48.0/20" #1760 pods / 16 nodes
Prod Services Subnet  = "10.0.34.0/23"  #512 services / 16 nodes

Bastion Subnet        = "10.0.32.8/29" #4 nodes
```

### App3

```bash
Dev Node Subnet       = "10.0.64.0/29" #4 nodes
Dev Pod Subnet        = "10.0.68.0/22" #440 pods / 4 nodes
Dev Services Subnet   = "10.0.64.128/25" #128 services / 4 nodes
Prod Node Subnet      = "10.0.64.16/28" #12 nodes
Prod Pod Subnet       = "10.0.80.0/20" #1760 pods / 16 nodes
Prod Services Subnet  = "10.0.66.0/23" #512 services / 16 nodes

Bastion Subnet        = "10.0.64.8/29" #4 nodes
```

The VPCs are deployed as follows: 

![Deployed VPCs for the Organisation](https://github.com/mharris-t/gcp-gke-project/blob/main/diagrams/figures/gke_networking.png)

In every VPC in this scope of this project, a bastion VM (e2-micro) is deployed to enable access to the private cluster endpoints within each cluster. Users can employ GCP's Identity Aware Proxy (IAP) to access the VM, ensuring secure access. Also, the bastion VM can access internet throught the NAT instance. The manner a user can access the cluster endpoints is as follows:

![Bastion VM to access private GKE clusters](https://github.com/mharris-t/gcp-gke-project/blob/main/diagrams/figures/gke_bastion_networking.png)

