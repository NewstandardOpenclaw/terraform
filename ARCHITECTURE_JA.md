# OpenClaw on AWS 構成図（やさしめ）

Terraformで管理している対象のイメージです。

```mermaid
flowchart TD
  U[あなたのPC] -->|SSH| EC2[EC2: OpenClaw]
  U -->|Git push| GH[GitHub: terraform repo]

  subgraph AWS[ap-northeast-1]
    VPC[VPC]
    SUBNET[Subnet]
    SG[Security Group]
    EC2
    EIP[(Elastic IP<br/>任意)]
  end

  VPC --> SUBNET
  SUBNET --> EC2
  SG --> EC2
  EIP -. associate_eip=true の時 .-> EC2

  TF[Terraform] -->|apply| AWS
  TF -->|state管理| STATE[.tfstate<br/>※公開しない]
```

---

## いまのあなたの状態

- EC2: `i-xxxxxxxxxxxxxxxxx`
- VPC: `vpc-xxxxxxxxxxxxxxxxx`
- Subnet: `subnet-xxxxxxxxxxxxxxxxx`
- SG: `sg-xxxxxxxxxxxxxxxxx`
- EIP: なし（現在）

---

## 操作フロー図

```mermaid
sequenceDiagram
  participant You as あなた
  participant TF as Terraform
  participant AWS as AWS

  You->>TF: terraform init
  You->>TF: terraform import (SG/EC2)
  You->>TF: terraform plan
  TF->>AWS: 差分チェック
  AWS-->>TF: 現在構成
  TF-->>You: 変更予定を表示
  You->>TF: terraform apply（必要時のみ）
  TF->>AWS: 構成反映
```

---

## 注意

- `.tfstate` と `terraform.tfvars` は公開しない
- まずは `plan` まで（`apply` は意図が固まってから）
