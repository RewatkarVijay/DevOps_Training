## To create User Groups
resource "aws_iam_group" "developer" {
  name = "Developer"
}

resource "aws_iam_group" "user" {
  name = "User"
}

resource "aws_iam_user_group_membership" "developer" {
  user = aws_iam_user.q1_developer.name

  groups = [
    aws_iam_group.developer.name,
  ]
}

resource "aws_iam_user_group_membership" "user" {
  user = aws_iam_user.q1_user.name

  groups = [
    aws_iam_group.user.name
  ]
}