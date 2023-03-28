resource "aws_iam_role" "eks-cluster-tfcb-jsgu" {
  name = "eks-cluster-${var.cluster_name}-jsgu"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
