# Terraform はじめてガイド（超かんたん版）

「AWSの設定をコードで管理する」ためのメモです。  
このリポジトリでは `openclaw-aws/` が本体です。

---

## 1. これで何がうれしい？

- いまのサーバー設定を **再現できる**
- 手作業ミスを減らせる
- 変更履歴がGitに残る

---

## 2. ファイルの意味（これだけ覚える）

- `providers.tf` : AWSにつなぐ設定
- `variables.tf` : 変数の定義（入力項目）
- `terraform.tfvars` : 実際の値（あなたの環境値）
- `main.tf` : 作るもの本体（EC2など）
- `outputs.tf` : 実行後に表示したい情報
- `README.md` : 使い方

---

## 3. まずやること（コピペ）

```bash
cd openclaw-aws
terraform init
terraform plan
```

- `init` = 準備
- `plan` = 何が変わるか確認（まだ変更しない）

---

## 4. いまの構成を取り込む（import）

```bash
terraform import aws_security_group.openclaw sg-xxxxxxxxxxxxxxxxx
terraform import aws_instance.openclaw i-xxxxxxxxxxxxxxxxx
terraform plan
```

ポイント：
- `import` は「既存AWSをTerraform管理に登録する」だけ
- そのあと `plan` で差分が出るか確認

---

## 5. 注意（大事）

- `terraform.tfvars` は公開しないのが基本
- `*.tfstate` も公開しない（機密が入る）
- 変更は必ず `plan` を見てから

---

## 6. よくある不安

### Q. これ実行したらサーバー落ちる？
A. `init` と `plan` だけなら落ちない。まずは安全。

### Q. いつ変更される？
A. `terraform apply` したときだけ。

### Q. 何が正解か分からない
A. `plan` の結果を貼ってくれれば、どこを直すか一緒に見れる。

---

## 7. 次の一歩

1. `terraform init`
2. `terraform import ...`
3. `terraform plan` の結果を共有

ここまでできれば、あとは私が調整を案内します。