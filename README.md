##################################################################################################

**terraform-s3-backend-management**

##################################################################################################

Purpose:
This Terraform project sets up a secure environment for Terraform state management using an S3 bucket to store the state and a DynamoDB table for state locking.
This setup ensures server-side encryption, state versioning and prevention against accidental destruction of the S3 bucket.

Prerequisites:
- Terraform v0.12.x or higher;
- AWS account with access configured in your development environment and with the necessary permissions to create S3 and DynamoDB resources.

Created Resources:
**S3 Bucket** An S3 bucket is created to store the Terraform state. The creation is controlled by the `create_s3_bucket` variable, and the bucket's name is defined by the `bucket_name` variable.
**S3 Bucket Encryption** Configures server-side encryption for the S3 bucket using the AES256 algorithm.
**S3 Bucket Versioning** Enables versioning on the S3 bucket to allow tracking and recovery of previous versions of the Terraform state.
**DynamoDB Table** Creates a DynamoDB table for each project specified in the `projects` variable for state locking, ensuring that only one Terraform execution can modify the state at a time.

How to create the backend file in a new project:
1 - In the `variables.tf` file, add the name of the new project to the `projects` variable;
2 - After applying the updated code, check the outputs and locate the name of the newly added file;
3 - Copy this output and place it in the new project in a `backend.tf` file.

The structure of the code should be as follows:

terraform {
  backend "s3" {
    bucket         = Name of the S3 bucket, defined by the `bucket_name` variable.
    key            = Project name (from the `projects` variable) followed by "/terraform.tfstate".
    region         = AWS region, defined by the `region` variable.
    dynamodb_table = Name of the DynamoDB table for state locking, based on the table created for each project.
    encrypt        = true  # Enables ecryption for the S3 bucket.                                                        
  }
}

This procedure should be adopted for this project as well, as it encourages the implementation of best practices from the start, ensuring that the environment is prepared for safe and organized use.
