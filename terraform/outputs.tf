output "backend_configuration" {
  description = "The exact backend.tf content for each project."
  value = {
    for proj in var.projects :
    proj => <<EOT
terraform {
  backend "s3" {
    bucket         = "${aws_s3_bucket.terraform_state[0].bucket}"
    key            = "${proj}/terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "${aws_dynamodb_table.dynamodb_terraform_lock[proj].name}"
    encrypt        = true
  }
}
EOT
  }
}
