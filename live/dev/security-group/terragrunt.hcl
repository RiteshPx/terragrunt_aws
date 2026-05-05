include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/security-group"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "vpc-12345678"
  }

  mock_outputs_allowed_terraform_commands = ["plan"]
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}