# gcp-gke-project
This is a TF code for deploying a GCP project with GKE clusters and some service controls. 

```bash
.
├── README.md
├── gke-project-app1
│   ├── app1-bastion.tf
│   ├── app1-gke.tf
│   └── providers.tf
├── gke-project-app2
│   ├── app2-bastion.tf
│   ├── app2-gke.tf
│   └── providers.tf
├── gke-project-app3
│   ├── app3-bastion.tf
│   ├── app3-gke.tf
│   └── providers.tf
├── governance
│   ├── gcp-iam.tf
│   ├── gcp-import-sources.tf
│   ├── gcp-projects.tf
│   ├── gcp-svc-acc-var.tf
│   ├── gcp-svc-acc.tf
│   ├── gcp-users.tf
│   ├── outputs.tf
│   └── providers.tf
└── networking
    ├── networking-nat.tf
    ├── networking-vpc.tf
    ├── outputs.tf
    └── providers.tf

6 directories, 22 files
```