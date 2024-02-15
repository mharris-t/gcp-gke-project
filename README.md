# gcp-gke-project

This is a code repository containing Terraform (TF) code for an organisation deploying cloud-native applications in Kubernetes clusters. The main requirement for this organization is to have Dev & Prod clusters for blue/green deployments, which are intended for testing and releasing the applications developed by the development team within the organisation. Furthermore, it is required that the organisation has control over Kubernetes release upgrades in GCP, so that the applications deployed in the clusters do not break after automatic upgrade of the Kubernetes control plane. 

This Git repository should not be considered a monorepository. Each main folder is considered a Git repository of its own, where resources defined in the TF repositories can be deployed with CI/CD pipeline tools such as GCP Cloudbuild and GitHub Actions.

The organisation has divided their cloud-native application development into three, namely:

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