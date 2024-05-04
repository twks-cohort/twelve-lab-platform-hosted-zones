locals {
  domain_cdicohorts_twelve = "cdicohorts-twelve.com"
}

provider "aws" {
  alias  = "domain_cdicohorts_twelve"
  region = "us-east-2"
  assume_role {
    role_arn = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
  }
}

# zone id for the top-level-zone
data "aws_route53_zone" "zone_id_cdicohorts_twelve" {
  provider = aws.domain_cdicohorts_twelve
  name     = local.domain_cdicohorts_twelve
}
