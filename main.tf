resource "aws_iam_role" "iam_for_lambda" {
    name = "${var.env_namespace}_lambda_role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "iam_policy_for_lambda" {
    role = aws_iam_role.iam_for_lambda.name
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "${var.ecr_repo_arn}"
      ],
      "Action": [
        "ecr:*"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "ecr:GetAuthorizationToken"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "rds:*"
      ]
    },
    {
        "Effect": "Allow",
        "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "ec2:AssignPrivateIpAddresses",
                "ec2:UnassignPrivateIpAddresses"
        ],
        "Resource": "*"
    }
  ]
}
POLICY
}
resource "aws_lambda_function" "main" {
    function_name   = "${var.env_namespace}_lambda"
    image_uri       = "${var.ecr_repo_url}:latest"
    package_type    = "Image"
    role            = aws_iam_role.iam_for_lambda.arn
    vpc_config {
        subnet_ids         = [var.subnet_id]
        security_group_ids = [var.sg_id]
    }
    environment {
        variables = {
            "RDS_HOST": var.rds_host
            "RDS_DB_USERNAME": var.rds_db_username
            "RDS_DB_PASSWORD": var.rds_db_password
            "RDS_DB_NAME": var.rds_db_name
        }
    }
}