resource "aws_iam_policy" "p_developer" {
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

resource "aws_iam_policy" "p_user" {
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
    user = aws_iam_user.user_deepali.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess" #arn:aws:iam::aws:policy/AmazonEC2FullAccess 
    #arn:aws:iam::aws:policy/AIOpsOperatorAccess
}

resource "aws_iam_group_policy_attachment" "gpa_developer" {
  group      = aws_iam_group.gp_developers.name
  policy_arn = aws_iam_policy.p_developer.name
}

resource "aws_iam_group_policy_attachment" "gpa_users" {
  group      = aws_iam_group.gp_users.name
  policy_arn = aws_iam_policy.p_user.name
}

resource "aws_iam_group_policy_attachment" "gpa_users1" {
  group      = aws_iam_group.gp_users.name
  policy_arn = "arn:aws:iam::aws:policy/AIOpsOperatorAccess"
}