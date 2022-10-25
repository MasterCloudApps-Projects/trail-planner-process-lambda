variable "env_namespace" {
    type = string
    description = "Value is coming from tfvars file that is being updated by buildspec environment variables"
}
variable "ecr_repo_url" {
    type = string
    description = "Value is coming from tfvars file that is being updated by buildspec environment variables"
}
variable "ecr_repo_arn" {
    type = string
    description = "Value is coming from tfvars file that is being updated by buildspec environment variables"
}
variable "rds_host" {
    type = string
    description = "Rds host value complete"
}
variable "rds_db_username" {
    type = string
    description = "Rds host value complete"
}
variable "rds_db_password" {
    type = string
    description = "Rds host value complete"
}
variable "rds_db_name" {
    type = string
    description = "Rds host value complete"
}
variable "subnet_id" {
    type = string
    description = "Rds host value complete"
}
variable "sg_id" {
    type = string
    description = "Rds host value complete"
}