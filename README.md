# Infrastructure as Code Tutorial (Terraform)

Install Terraform

Run these brew commands in your terminal or follow the install guide.

https://learn.hashicorp.com/tutorials/terraform/install-cli

```
$ brew tap hashicorp/tap
```

```
$ brew install hashicorp/tap/terraform
```

Make a bucket and dynamodb table to store terraform state

```
$ aws s3api create-bucket --bucket $BUCKET_NAME --region us-east-1 --create-bucket-configuration LocationConstraint=us-east-1

$ aws s3api put-bucket-encryption --bucket $BUCKET_NAME --server-side-encryption-configuration "{\"Rules\": [{\"ApplyServerSideEncryptionByDefault\":{\"SSEAlgorithm\": \"AES256\"}}]}"

$ aws dynamodb create-table --table-name terraform-lock-table --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

$BUCKET_NAME must be unique in all .tf files

Run init

```
$ terraform init
```

This command will show you what will change in the cloud.

```
$ terraform plan
```

This command will apply your changes

```
$ terraform apply
```

This code repo contains the minimum config needed to deploy an AWS Lambda to run a python function in the cloud. 