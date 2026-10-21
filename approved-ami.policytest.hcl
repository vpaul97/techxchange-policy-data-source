policytest {
  targets = ["approved-ami.policy.hcl"]
}

data "aws_ami" "approved" {
  attrs = {
    id          = "ami-0123456789abcdef0"
    owners      = ["amazon"]
    name_regex  = "^al2023-ami-2023.*-arm64$"
    most_recent = true
  }
}

resource "aws_instance" "approved" {
  attrs = {
    ami           = "ami-0123456789abcdef0"
    instance_type = "t4g.micro"
  }
}

resource "aws_instance" "unapproved" {
  expect_failure = true
  attrs = {
    ami           = "ami-0fedcba9876543210"
    instance_type = "t4g.micro"
  }
}
