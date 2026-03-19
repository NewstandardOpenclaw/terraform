output "instance_id" {
  value = aws_instance.openclaw.id
}

output "private_ip" {
  value = aws_instance.openclaw.private_ip
}

output "public_ip" {
  value = var.associate_eip ? aws_eip.openclaw[0].public_ip : aws_instance.openclaw.public_ip
}

output "security_group_id" {
  value = aws_security_group.openclaw.id
}

output "iam_instance_profile" {
  value = var.attach_instance_profile ? aws_iam_instance_profile.openclaw[0].name : null
}
