policy {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0, < 7.0.0"
    }
  }
}

locals {
  approved_ami = core::getdatasource("aws_ami", {
    owners      = ["amazon"]
    name_regex  = "^al2023-ami-2023.*-arm64$"
    most_recent = true
  })
}

resource_policy "aws_instance" "approved_ami" {
  enforce {
    condition     = attrs.ami == local.approved_ami.id
    error_message = "AMI '${attrs.ami}' is not the approved AMI '${local.approved_ami.id}'."
  }
}
