# AWS EKS Infrastructure

This repository contains Terraform configurations for managing Amazon Elastic Kubernetes Service (EKS) clusters. It provides a complete infrastructure setup for container orchestration with ArgoCD for GitOps deployment management.

## 🏗️ Infrastructure Overview

This Terraform project manages:

- **AWS EKS Cluster**: Kubernetes cluster with managed node groups
- **VPC Infrastructure**: Custom VPC with public and private subnets
- **ArgoCD Deployment**: GitOps continuous deployment platform
- **Node Groups**: Managed EKS node groups for workload execution
- **Modular Design**: Reusable EKS and VPC modules for scalable infrastructure

## 📁 Project Structure

```
terraform-eks/
├── main.tf               # EKS cluster and VPC configuration
├── argocd.tf             # ArgoCD Helm deployment
├── providers.tf          # AWS, Kubernetes, and Helm provider configuration
├── data.tf               # Data sources for EKS authentication
├── outputs.tf            # Cluster outputs and endpoints
├── backend.tf            # Terraform backend configuration
└── helm-values/
    └── argocd-values.yaml # ArgoCD Helm chart values
```

## 🚀 Features

### EKS Cluster
- **Managed Kubernetes**: AWS-managed Kubernetes control plane
- **Multi-AZ Deployment**: Cluster deployed across multiple availability zones
- **Public/Private Access**: Both public and private endpoint access enabled
- **API Authentication**: Secure cluster access with AWS IAM integration
- **Node Groups**: Managed node groups with auto-scaling capabilities

### VPC Infrastructure
- **Custom VPC**: Dedicated VPC with CIDR 10.0.0.0/16
- **Multi-AZ Subnets**: Public and private subnets across 2 availability zones
- **Network Isolation**: Proper network segmentation for security
- **Auto-assign Public IPs**: Public subnets configured for internet access

### ArgoCD Integration
- **GitOps Platform**: Automated deployment from Git repositories
- **Helm Chart Management**: Deployed using Helm with custom values
- **ChartMuseum Integration**: Connected to external Helm chart repository
- **Reconciliation**: Automated sync with 30-second reconciliation timeout

## 🔧 Prerequisites

- **Terraform** >= 1.0
- **AWS CLI** configured with appropriate credentials
- **kubectl** for Kubernetes cluster interaction
- **helm** for Helm chart management
- **AWS S3 Backend**: Configured S3 bucket for Terraform state storage

## 📋 Requirements

### AWS Requirements
- AWS account with appropriate permissions for:
  - EKS cluster creation and management
  - VPC and networking resources
  - IAM roles and policies for EKS operations
  - S3 bucket access for Terraform state
  - EC2 instance management for node groups

### Terraform Providers
- `hashicorp/aws` ~> 5.0 - AWS provider
- `hashicorp/helm` ~> 2.17.0 - Helm provider
- `hashicorp/kubernetes` - Kubernetes provider

## 🚀 Quick Start

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Review the Plan
```bash
terraform plan
```

### 3. Apply the Configuration
```bash
terraform apply
```

### 4. Configure kubectl
After successful deployment, configure kubectl to access your cluster:
```bash
aws eks update-kubeconfig --region us-east-1 --name unir-tfm-eks-cluster
```

### 5. Access ArgoCD
Get the ArgoCD admin password and access the UI:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

## 🔐 Security Considerations

### Cluster Security
- **API Authentication**: Uses AWS IAM for cluster access control
- **Network Security**: VPC with proper subnet isolation
- **Node Security**: Managed node groups with security groups
- **Encryption**: EKS-managed encryption for data at rest

### Production Security Recommendations

1. **Private Subnets**: Consider using private subnets for worker nodes
2. **NAT Gateways**: Enable NAT gateways for private subnet internet access
3. **Security Groups**: Implement restrictive security group rules
4. **IAM Roles**: Use least-privilege IAM roles for node groups
5. **Secrets Management**: Implement proper secrets management for applications
6. **Network Policies**: Deploy network policies for pod-to-pod communication

## 📊 Outputs

The EKS infrastructure provides the following outputs:

| Output | Description |
|--------|-------------|
| `cluster_name` | The name of the EKS cluster |
| `cluster_endpoint` | The endpoint for the EKS cluster API server |

## 🧹 Cleanup

To destroy all resources:
```bash
terraform destroy
```

⚠️ **Warning**: This will permanently delete the EKS cluster, VPC, and all associated resources.

## 🔧 Customization

### Cluster Configuration
Modify `main.tf` to adjust:
- Cluster version and name
- Node group instance types and sizing
- Subnet configuration
- Authentication settings

### VPC Configuration
Modify the VPC module in `main.tf` to adjust:
- CIDR blocks and subnet ranges
- Availability zone selection
- NAT gateway configuration
- Network ACLs and security groups

### ArgoCD Configuration
Modify `helm-values/argocd-values.yaml` to adjust:
- Service type and configuration
- Repository connections
- Reconciliation settings
- RBAC and security settings

## 📝 Notes

- **State Management**: Uses S3 backend for remote state storage
- **Region**: Configured for us-east-1 region
- **Project Tagging**: All resources are tagged with `Environment = "dev"`
- **Node Groups**: Currently configured with t3.small instances
- **ArgoCD**: Deployed with ClusterIP service type for internal access
- **ChartMuseum**: Connected to external Helm repository at 3.238.99.68

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `terraform plan`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
