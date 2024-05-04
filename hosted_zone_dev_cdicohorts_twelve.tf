# *.dev.twdps.digital

# define a provider in the account where this subdomain will be managed
provider "aws" {
  alias  = "subdomain_dev_cdicohorts_twelve"
  region = "ap-southeast-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "twelve-lab-platform-hosted-zones"
  }
}

# create a route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_dev_cdicohorts_twelve" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.subdomain_dev_cdicohorts_twelve
  }

  zones = {
    "dev.${local.domain_cdicohorts_twelve}" = {
      tags = {
        cluster = "nonprod"
      }
    }
  }

  tags = {
    pipeline = "twelve-lab-platform-hosted-zones"
  }
}

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_dev_cdicohorts_twelve" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.domain_cdicohorts_twelve
  }

  private_zone = false
  zone_name = local.domain_cdicohorts_twelve
  records = [
    {
      name            = "dev"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.zone_id_cdicohorts_twelve.id
      allow_overwrite = true
      records         = lookup(module.subdomain_dev_cdicohorts_twelve.route53_zone_name_servers,"dev.${local.domain_cdicohorts_twelve}")
    }
  ]

  depends_on = [module.subdomain_dev_cdicohorts_twelve]
}
