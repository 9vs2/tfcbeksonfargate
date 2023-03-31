resource "aws_iam_role" "eks-cluster" {
  name = "eks-cluster-${var.cluster_name}"

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

resource "aws_iam_role_policy_attachment" "amazon-eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {

    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]

    subnet_ids = [
      aws_subnet.private-ap-northeast-3a.id,
      aws_subnet.private-ap-northeast-3b.id,
      aws_subnet.public-ap-northeast-3a.id,
      aws_subnet.public-ap-northeast-3b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.amazon-eks-cluster-policy]
}

module "eks_auth" {
  source = "aidanmelen/eks-auth/aws"
  eks    = aws_iam_role.eks-cluster

  map_roles = [
    {
      rolearn  = "arn:aws:sts::789535401130:assumed-role/CCOE/CCOE@KESBOXCOE"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]

  map_accounts = [
    "789535401130"
  ]
}