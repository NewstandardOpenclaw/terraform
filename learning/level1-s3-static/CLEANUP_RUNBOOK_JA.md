# Level1 クリーンアップ設計（不要時に確実に消す）

目的: 学習環境を使い終わったら、確実に削除して課金を残さない。

---

## 方針

1. **作成前にタグを統一**（Project / Level / Owner）
2. **状態ファイルを保持**（destroyに必要）
3. **削除コマンドを固定化**（手順ブレ防止）
4. **削除後確認**（S3バケットが残ってないか確認）

---

## 実行手順

```bash
cd learning/level1-s3-static
terraform plan -destroy
terraform destroy -auto-approve
```

---

## 削除後チェック

```bash
# 1) Terraform state が空か
terraform state list || true

# 2) バケットが無いか（バケット名はtfvarsの値）
aws s3 ls | grep your-unique-bucket-name-12345 || echo "bucket not found: OK"
```

---

## 事故防止ルール

- `apply` 前に必ず `plan` を見る
- `destroy` 前にリージョンとバケット名を再確認
- 学習が終わったら当日中に `destroy`

---

## 追記（次レベル以降）

Level2以降も同じく `plan -destroy` → `destroy` → `確認` の3点セットで運用する。
