# Level 1: S3 Bucket（Terraform学習用）

最初の学習用サンプルです。  
作るものは **S3バケット1つ**（versioning有効 + public block有効）。

## 学べること
- provider / variable / output の基本
- resource の依存関係
- `terraform init/plan/apply/destroy` の流れ

## 使い方
```bash
cd learning/level1-s3-static
cp terraform.tfvars.example terraform.tfvars
# bucket_name を必ず一意な名前に変更
terraform init
terraform plan
terraform apply
```

## 削除
```bash
terraform destroy
```

## 注意
- `terraform.tfvars` はコミットしない
- バケット名は全世界で一意
