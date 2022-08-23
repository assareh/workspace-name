# https://github.com/hashicorp/terraform/issues/22802

# commenting out to run with a VCS workflow
# terraform {
#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = var.organization

#     workspaces {
#         name = ""
#       # prefix = "my-workspace-" # copy your workspace prefix on trimprefix("${var.TFC_WORKSPACE_NAME}", "my-workspace-") function
#     }
#   }
# }

# variable "organization" {
#   type = string
# }

variable "TFC_WORKSPACE_NAME" {
  type = string
  default = "" # An error occurs when you are running TF backend other than Terraform Cloud
}

locals {
  # If your backend is not Terraform Cloud, the value is ${terraform.workspace} 
  # otherwise the value retrieved is that of the TFC_WORKSPACE_NAME with trimprefix
  my_workspace_env = var.TFC_WORKSPACE_NAME != "" ? trimprefix("${var.TFC_WORKSPACE_NAME}", "my-workspace-") : "${terraform.workspace}"
}

output "workspace" {
  value = local.my_workspace_env
}