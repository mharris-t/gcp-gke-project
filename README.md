# gcp-gke-project
This is a TF code for deploying a GCP project with GKE clusters and some service controls. 

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