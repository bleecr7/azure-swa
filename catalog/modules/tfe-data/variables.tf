variable "remote_state_org_name" {
  description = "The name of the Terraform Enterprise organization storing the remote state"
  type        = string
}

variable "remote_state_workspace_name" {
  description = "The name of the Terraform Enterprise workspace storing the remote state"
  type        = string
}