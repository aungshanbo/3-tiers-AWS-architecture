# 3-Tiers AWS Architecture using Terraform

## ✨ Project Overview
This project sets up a **3-tier architecture** on AWS using **Terraform**, including:
- **Web Tier**: Load Balancer with Auto Scaling
- **App Tier**: EC2 instances with Auto Scaling
- **Database Tier**: RDS (Relational Database Service)

The infrastructure is designed to be **highly available** and **scalable**.

---

## 🛠️ Features
- ✅ Fully automated deployment using **Terraform**
- ✅ Implements **Auto Scaling Groups** for high availability
- ✅ Uses an **Application Load Balancer (ALB)** for traffic distribution
- ✅ Secure **RDS database** instance with private networking
- ✅ Follows **AWS best practices**

---

## 💪 Technologies Used
- **Terraform** for Infrastructure as Code (IaC)
- **AWS EC2, ALB, ASG, RDS**
- **VPC, Subnets, Security Groups, IGW and NAT GW**
- **Bash Scripting (User Data for EC2 setup)**

---

## 💻 Installation & Setup
### 1️⃣ Prerequisites
Make sure you have:
- **Terraform** installed → [Download Terraform](https://developer.hashicorp.com/terraform/downloads)
- **AWS CLI** installed and configured → `aws configure`
- **Git** installed → `git --version`

### 2️⃣ Clone the Repository
```sh
git clone https://github.com/aungshanbo/3-tiers-AWS-architecture.git
cd 3-tiers-AWS-architecture
```

### 3️⃣ Initialize Terraform
```sh
terraform init
```

### 4️⃣ Deploy Infrastructure
```sh
terraform apply -auto-approve
```

### 5️⃣ Destroy Infrastructure (When Needed)
```sh
terraform destroy -auto-approve
```

---

## 📂 Project Structure
```
3-tiers-AWS-architecture/
│── webtier.tf         # Web tier (ALB, ASG)
│── apptier.tf         # Application tier (EC2, ASG)
│── dbtier.tf          # Database tier (RDS)
│── igw.tf             # Internet Gateway
│── route_tables.tf    # Route Table 
│── security_gp.tf     # Security Group
│── subnet.tf          # Subnet
│── vpc.tf             # VPC
│── variables.tf       # Variables for Terraform
│── outputs.tf         # Output values
│── README.md          # Project documentation
```

---

## 🔒 Security Best Practices
- **Private subnets** for application and database tiers
- **Security groups** restrict access between tiers

---
