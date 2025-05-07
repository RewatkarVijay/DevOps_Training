resource "aws_iam_group" "gp_developers" {
  name = "Developers"
}

resource "aws_iam_group" "gp_users" {
  name = "Users"
}

resource "aws_iam_user_group_membership" "gm_developer" {
  user = aws_iam_user.user_vijay.name

  groups = [
    aws_iam_group.gp_developers.name,
  ]
}

resource "aws_iam_user_group_membership" "gm_users" {
  user = aws_iam_user.user_deepali.name

  groups = [
    aws_iam_group.gp_users.name
  ]
}