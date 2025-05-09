resource "aws_iam_policy" "developer" {
  name        = "DT_S3_Full_Access"
  #description = "A Demo policy"
  policy      = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
)
}

resource "aws_iam_policy" "user" {
  name        = "test-policy"
  description = "A test policy"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "autoscaling.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com",
                        "transitgateway.amazonaws.com"
                    ]
                }
            }
        }
    ]
})
}


# resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
#     user = aws_iam_user.user_vijay.name
#     policy_arn = aws_iam_policy.policy.arn
# }

resource "aws_iam_user_policy_attachment" "user_policy_attachment1" {
    user = aws_iam_user.vishal-t.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess" #arn:aws:iam::aws:policy/AmazonEC2FullAccess 
    #arn:aws:iam::aws:policy/AIOpsOperatorAccess
}


resource "aws_iam_group_policy" "qa1_developer_policy" {
  name  = "qa1_developer_policy"
  group = aws_iam_group.gp_developers.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "qa1_developer" {
  group      = aws_iam_group.developer.name
  policy_arn = aws_iam_policy.developer.arn
}

resource "aws_iam_group_policy_attachment" "qa1_user" {
  group      = aws_iam_group.user.name
  policy_arn = aws_iam_policy.user.arn
}

resource "aws_iam_group_policy_attachment" "qa1_user_AIOpsOperatorAccess" {
  group      = aws_iam_group.user.name
  policy_arn = "arn:aws:iam::aws:policy/AIOpsOperatorAccess"
}
