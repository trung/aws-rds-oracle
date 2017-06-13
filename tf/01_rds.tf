resource "aws_db_parameter_group" "OracleEE121ParamGroup" {
  family = "oracle-ee-12.1"
  parameter {
    name = "audit_trail"
    value = "XML"
  }
  parameter {
    name = "control_managent_pack_access"
    value = "DIAGOSTIC+TUNING"
  }
  parameter {
    name = "control_file_record_keep_time"
    value = "31"
  }
  parameter {
    name = "db_block_checksum"
    value = "FULL"
  }
  parameter {
    name = "db_block_checking"
    value = "FULL"
  }
  parameter {
    name = "db_flashback_retention_target"
    value = "120"
  }
  parameter {
    name = "db_lost_write_protect"
    value = "TYPICAL"
  }
  parameter {
    name = "db_ultra_safe"
    value = "OFF"
  }
  parameter {
    name = "fast_start_mttr_target"
    value = "300"
  }
  parameter {
    name = "log_buffer"
    value = "16777216"
  }
  parameter {
    name = "max_dump_file_size"
    value = "10M"
  }
  parameter {
    name = "optimizer_mode"
    value = "ALL_ROWS"
  }
  parameter {
    name = "open_cursors"
    value = "2048"
  }
  parameter {
    name = "parallel_execution_message_size"
    value = "32768"
  }
  parameter {
    name = "processes"
    value = "1500"
  }
  parameter {
    name = "statistics_level"
    value = "TYPICAL"
  }
  parameter {
    name = "undo_retention"
    value = "86400"
  }
  parameter {
    name = "sql92_security"
    value = "TRUE"
  }
  parameter {
    name = "resource_limit"
    value = "TRUE"
  }
  parameter {
    name = "sec_max_failed_login_attempts"
    value = "5"
  }
  parameter {
    name = "sec_protocol_error_buffer_further_action"
    value = "(DELAY,30)"
  }
  parameter {
    name = "sec_protocol_error_trace_action"
    value = "LOG"
  }

  # FIXME more to come

  tags = "${var.CommonTags}"
}

resource "aws_db_subnet_group" "DBSubnetGroup" {
  subnet_ids = ["${var.Subnets}"]

  tags = "${var.CommonTags}"
}

resource "aws_db_option_group" "OracleEE121OptionGroup" {
  engine_name = "oracle-ee"
  major_engine_version = "12.1"
  tags = "${var.CommonTags}"
  option {
    option_name = "NATIVE_NETWORK_ENCRYPTION"
    option_settings {
      name = "SQLNET.ENCRYPTION_SERVER"
      value = "REQUIRED"
    }
    option_settings {
      name = "SQLNET.CRYPTO_CHECKSUM_SERVER"
      value = "REQUIRED"
    }
    option_settings {
      name = "SQLNET.ENCRYPTION_TYPES_SERVER"
      value = "AES256"
    }
    option_settings {
      name = "SQLNET.CRYPTO_CHECKSUM_TYPES_SERVER"
      value = "REQUIRED"
    }
  }
}

resource "aws_db_instance" "DBInstance" {
  allocated_storage = "${var.DBStorageSize}"
  auto_minor_version_upgrade = "false"
  backup_retention_period = "${var.BackupRetention}"
  character_set_name = "AL32UTF8"
  copy_tags_to_snapshot = "true"
  instance_class = "${var.DBInstanceType}"
  # FIXME DBInstanceIdentifier
  name = "${var.DBName}"
  parameter_group_name = "${aws_db_parameter_group.OracleEE121ParamGroup.name}"
  db_subnet_group_name = "${aws_db_subnet_group.DBSubnetGroup.name}"
  engine = "oracle-ee",
  engine_version = "12.1.0.2.v5"
  kms_key_id = "${var.KmsKeyId}"
  license_model = "bring-your-own-license"
  # FIXME MasterUserName
  # FIXME MasterUserPassword
  monitoring_interval = "60"
  monitoring_role_arn = "${var.MonitoringRoleArn}"
  multi_az = "${lookup(var.MultipleAZ, format("%s.%s", var.Environment, var.RTO))}"
  option_group_name = "${aws_db_option_group.OracleEE121OptionGroup.name}"
  port = "6140"
  backup_window = "${var.PreferredBackupWindow}"
  maintenance_window = "${var.PreferredMaintenanceWindow}"
  publicly_accessible = "false"
  storage_encrypted = "true"
  storage_type = "${var.DBStorageType}"
  vpc_security_group_ids = ["${var.VpcId}"]
  tags = "${var.CommonTags}"
}