include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnet_id = "subnet-12345678"
  }

  mock_outputs_allowed_terraform_commands = ["plan"]
}

dependency "sg" {
  config_path = "../security-group"

  mock_outputs = {
    sg_id = "sg-12345678"
  }

  mock_outputs_allowed_terraform_commands = ["plan"]
}

inputs = {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t3.micro"

  subnet_id = dependency.vpc.outputs.public_subnet_id
  sg_id     = dependency.sg.outputs.sg_id
  key_name  = "terraform-key"
}