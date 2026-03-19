# 実行コマンドまとめ（Terraform / AWS）

このページは「そのままコピペして使う」用です。

---

## 1) Terraformの基本

```bash
cd openclaw-aws
terraform init
terraform plan
```

- `init`: 準備
- `plan`: 変更予定の確認（まだ変更しない）

---

## 2) 既存AWSをTerraformへ取り込む（import）

```bash
cd openclaw-aws
terraform import aws_security_group.openclaw sg-xxxxxxxxxxxxxxxxx
terraform import aws_instance.openclaw i-xxxxxxxxxxxxxxxxx
terraform plan
```

---

## 3) AWS情報を取得するコマンド（確認用）

### 3-1. リージョン
```bash
aws configure get region
```

### 3-2. インスタンス一覧（Nameタグつき）
```bash
aws ec2 describe-instances \
  --query "Reservations[].Instances[].{InstanceId:InstanceId,State:State.Name,Type:InstanceType,VpcId:VpcId,SubnetId:SubnetId,KeyName:KeyName,PublicIp:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,IamProfile:IamInstanceProfile.Arn}" \
  --output table
```

### 3-3. AMI ID
```bash
INSTANCE_ID=i-xxxxxxxxxxxxxxxxx
aws ec2 describe-instances --instance-ids $INSTANCE_ID \
  --query "Reservations[0].Instances[0].ImageId" --output text
```

### 3-4. EIP確認
```bash
aws ec2 describe-addresses \
  --query "Addresses[].{AllocationId:AllocationId,PublicIp:PublicIp,InstanceId:InstanceId}" \
  --output table
```

### 3-5. Security Group確認
```bash
aws ec2 describe-instances --instance-ids $INSTANCE_ID \
  --query "Reservations[0].Instances[0].SecurityGroups" --output table
```

### 3-6. IAM Instance Profile確認
```bash
aws ec2 describe-instances --instance-ids $INSTANCE_ID \
  --query "Reservations[0].Instances[0].IamInstanceProfile.Arn" --output text
```

---

## 4) 差分確認後に反映（必要時のみ）

```bash
cd openclaw-aws
terraform plan
terraform apply
```

> `apply` は本当に変更するときだけ実行。

---

## 5) Git操作（このリポジトリ）

```bash
git add .
git commit -m "update terraform docs"
git push origin main
```
