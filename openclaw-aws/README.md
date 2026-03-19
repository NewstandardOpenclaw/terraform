# OpenClaw on AWS (Terraform)

EC2で動かしているOpenClaw構成をTerraform管理に寄せるための土台です。

## 含まれるリソース
- EC2 instance (`aws_instance.openclaw`)
- Security Group (`aws_security_group.openclaw`)
- IAM Role + Instance Profile
- Optional Elastic IP

## 使い方（新規作成）
```bash
cd terraform/openclaw-aws
cp terraform.tfvars.example terraform.tfvars
# 値を編集
terraform init
terraform plan
terraform apply
```

## 既存環境をimportしてIaC化（推奨）
> 先に `terraform.tfvars` を実環境で埋めて `terraform init` してください。

```bash
cd terraform/openclaw-aws
terraform init

# 例: 既存リソースIDを指定してimport
terraform import aws_security_group.openclaw sg-xxxxxxxx
terraform import aws_iam_role.openclaw openclaw-ec2-role
terraform import aws_iam_instance_profile.openclaw openclaw-ec2-profile
terraform import aws_instance.openclaw i-xxxxxxxx
terraform import aws_eip.openclaw[0] eipalloc-xxxxxxxx  # associate_eip=trueの場合

terraform plan
```

`plan` で差分が出る場合は、`terraform.tfvars` / `main.tf` を現状に合わせて調整。

## 安全メモ
- OpenClawのポート(18789)は原則公開しない（必要ならリバプロ+制限）
- SSH CIDRは固定IPのみに絞る
- `.tfstate` は機密を含むのでGit管理しない

## 次に追加しやすいもの
- Route53レコード
- CloudWatchアラーム
- SSM Session Manager（SSHレス運用）
- EventBridgeで起動/停止スケジュール
