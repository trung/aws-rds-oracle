variable "CommonTags" {
  type = "map"
  default = {
    sid = "f413852"
    by = "tf"
  }
}
variable "SecurityGroupId" {
}
variable "DBAdminUser" {
  default = "admin"
}
variable "DBStorageSize" {
  default = "10"
}
variable "DBStorageType" {
  default = "standard"
}
variable "BackupRetention" {
  default = "2"
  description = "in days"
}
variable "PreferredBackupWindow" {
  default = "07:00-08:00"
}
variable "PreferredMaintenanceWindow" {
  default = "sun:09:00-sun:09:30"
}
variable "DBInstanceType" {
  default = "db.m4.large"
}
variable "DBName" {
  default = "SampleDB"
}
variable "Subnets" {
  type = "list"
}
variable "KmsKeyAlias" {

}
variable "MonitoringRoleArn" {
}
variable "MultipleAZ" {
  type = "map"
  default = {
    DEV.0 = "false"
    UAT.0 = "true"
    PROD.0 = "true"
    DEV.4 = "false"
    UAT.4 = "true"
    PROD.4 = "true"
    DEV.24 = "false"
    UAT.24 = "false"
    PROD.24 = "false"
    DEV.72 = "false"
    UAT.72 = "false"
    PROD.72 = "false"
  }
}
variable "Environment" {
  default = "DEV"
  description = "DEV, UAT or PROD"
}
variable "RTO" {
  default = "72"
  description = "0, 4, 24 or 72"
}