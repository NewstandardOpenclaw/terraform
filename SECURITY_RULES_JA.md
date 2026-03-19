# Terraform公開リポジトリ運用ルール（実ID/機密情報）

このリポジトリは public のため、以下を必ず守る。

---

## 1. 書いてよいもの
- Terraform構成コード（`main.tf` / `variables.tf` など）
- サンプル値（`vpc-xxxxxxxx` などマスク済み）
- 手順ドキュメント

---

## 2. 書いてはいけないもの
- `terraform.tfvars`（実値）
- `*.tfstate` / `*.tfstate.backup`
- Access Key / Secret Key / Token
- 秘密鍵（`.pem`, `.key`）
- OAuthの `client_secret` 本体
- 実インフラID（instance/vpc/subnet/sg/eip）をそのまま

---

## 3. ルール
1. 実IDは必ずマスクして記載（例: `i-xxxxxxxxxxxxxxxxx`）
2. 変更前に `git diff` で機密がないか確認
3. `terraform plan` 結果を共有する時もIDを必要最小限にする
4. 事故ったら即時に
   - 該当情報の削除
   - 履歴書き換え（必要時）
   - 必要に応じてID/鍵ローテーション

---

## 4. 最低限のチェックコマンド

```bash
# 実IDっぽいものが入ってないか（例）
git grep -nE 'i-[0-9a-f]{8,}|vpc-[0-9a-f]{8,}|subnet-[0-9a-f]{8,}|sg-[0-9a-f]{8,}|eipalloc-[0-9a-f]{8,}'

# tfvars/tfstate が追跡されてないか
git ls-files | grep -E 'terraform\.tfvars|\.tfstate' || true
```

---

## 5. 基本方針
「コードは公開可、実値は非公開」を徹底する。
