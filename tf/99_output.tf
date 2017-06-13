output "JDBCConnectionString" {
  value = "${format("jdbc:oracle:thin:@//%s:%s/%s", aws_db_instance.DBInstance.address, aws_db_instance.DBInstance.port, var.DBName)}"
}