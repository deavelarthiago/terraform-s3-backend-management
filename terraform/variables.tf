variable "region" {
  description = "AWS region where resources will be deployed. Set the default region to deploy resources if not specified."
  type        = string
  default     = "<specify default AWS region here>"
}

variable "create_s3_bucket" {
  description = "Whether to create the S3 bucket or not"
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "The name of the S3 bucket where the Terraform state files will be stored. Edit this value to specify your own bucket name."
  type        = string
  default     = "<specify your S3 bucket name here>"
}

variable "projects" {
  description = "List of project names to create separate DynamoDB lock tables for. Replace the examples projects with your own project names."
  type        = list(string)
  default = [

    "example-project-1",
    "example-project-2",
    "example-project-3"

  ] # Add or remove projects as needed
}
