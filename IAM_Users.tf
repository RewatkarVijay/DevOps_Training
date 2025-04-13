
    ## To create users
resource "aws_iam_user" "user_1" {
  name = "dt_Vijay"
  path = "/"
 
  tags = {
    tag-key = "dt_Vijay-tagname"
  }
}

resource "aws_iam_user" "user_2" {
  name = "dt_Vishal"
  path = "/system/"
 
  tags = {
    tag-key = "dt_Vishal-tagname"
  }
}


    ## To create policy
resource "aws_iam_policy" "policy" {
  name        = "Demo-policy"
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

    ## To attach policy to users
resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
    user = aws_iam_user.lb.name
    policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment1" {
    user = aws_iam_user.lb1.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}