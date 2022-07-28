/* 
Arquive the script
*/
data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "${path.module}/src/handler.py"
  output_path = "handler.zip"
}

/*
  Create the lamda function
*/
resource "aws_lambda_function" "test_lambda_function" {
    function_name = "lambdaTerraformTest"
    filename      = "handler.zip"
    source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
    role          = aws_iam_role.lambda_role.arn
    runtime       = "python3.9"
    handler       = "handler.handler"
    timeout       = 10
}