resource "aws_iam_group" "gp_developers" {
  name = "Developers"
}

resource "aws_iam_group" "gp_users" {
  name = "Users"
}

resource "aws_iam_user_group_membership" "gm_developer" {
  user = aws_iam_user.vijay-t.name

  groups = [
    aws_iam_group.gp_developers.name,
  ]
}

resource "aws_iam_user_group_membership" "gm_users" {
  user = aws_iam_user.vishal-t.name

  groups = [
    aws_iam_group.gp_users.name
  ]
}