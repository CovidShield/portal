data "aws_iam_policy_document" "covidshield" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

###
# AWS IAM - Key Retrieval
###

data "aws_iam_policy_document" "covidshield_secrets_manager_portal" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      aws_secretsmanager_secret.portal_env_rails_master_key.arn,
      aws_secretsmanager_secret.portal_database_url.arn,
    ]
  }
}

resource "aws_iam_policy" "covidshield_secrets_manager_portal" {
  name   = "CovidShieldSecretsManagerPortal"
  path   = "/"
  policy = data.aws_iam_policy_document.covidshield_secrets_manager_portal.json
}

resource "aws_iam_role" "covidshield_portal" {
  name = var.ecs_portal_name

  assume_role_policy = data.aws_iam_policy_document.covidshield.json

  tags = {
    (var.billing_tag_key) = var.billing_tag_value
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_portal" {
  role       = aws_iam_role.covidshield_portal.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "secrets_manager_portal" {
  role       = aws_iam_role.covidshield_portal.name
  policy_arn = aws_iam_policy.covidshield_secrets_manager_portal.arn
}
