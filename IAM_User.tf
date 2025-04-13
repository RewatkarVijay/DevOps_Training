
resource "aws_iam_user" "user_1" {
  name = "DT_Vijay"
  path = "/"
 
  tags = {
    tag-key = "DT_Vijay-tagname"
  }
}

resource "aws_iam_user" "user_2" {
  name = "DT_Vishal"
  path = "/system/"
 
  tags = {
    tag-key = "DT_Vishal-tagname"
  }
}


resource "aws_iam_policy" "policy" {
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

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
    user = aws_iam_user.user_1.name
    policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment1" {
    user = aws_iam_user.user_2.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}