
resource "aws_iam_user" "user_vijay" {
  name = "DT_Vijay"
  path = "/"
 
  tags = {
    tag-key = "DT_Vijay-tagname"
  }
}

resource "aws_iam_user" "user_deepali" {
  name = "DT_Vishal"
  path = "/system/"
 
  tags = {
    tag-key = "DT_Vishal-tagname"
  }
}


