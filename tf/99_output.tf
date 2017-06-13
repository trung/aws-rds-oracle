output "JDBCConnectionString" {
  value = "${format("jdbc:oracle:thin:@//%s/%s", aws_db_instance.DBInstance.endpoint, var.DBName)}"
}

output "DBAdminPassword" {
  value = "${random_id.DBAdminPassword.id}"
}