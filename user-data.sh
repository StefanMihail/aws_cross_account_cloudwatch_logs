#!/bin/bash
#installing the cloudwatch agent
yum install amazon-cloudwatch-agent -y

#Create the preconfigured Cloudwatch configuration file and save it under #/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
#create an empty file for the cloudwatch configuration 
touch /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

#the line "role_arn": "arn:aws:iam::*:role/cross-account-test" is optional only if you want to send the logs cross account 
#how to send logs cross accrount documentation:
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-common-scenarios.html#CloudWatch-Agent-adding-custom-dimensions 
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "agent": {
    "metrics_collection_interval": 60,
    "logfile": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
    "credentials": {
      "role_arn": "arn:aws:iam::{receiver_AWS_accountID}:role/cloudwatch_receiver_role"
    }
  },
  "logs": {
    "credentials": {
    "role_arn": "arn:aws:iam::{receiver_AWS_accountID}:role/cloudwatch_receiver_role"
    },
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/secure",
            "log_group_name": "secure-logs",
            "log_stream_name": "{instance_id}",
            "timezone": "UTC"
          },
          {
            "file_path": "/var/log/audit/audit.log",
            "log_group_name": "audit-logs",
            "log_stream_name": "{instance_id}",
            "timezone": "UTC"
          },
          {
            "file_path": "/var/log/cron",
            "log_group_name": "cron-logs",
            "log_stream_name": "{instance_id}",
            "timezone": "UTC"
          },
          {
            "file_path": "/var/log/yum.log",
            "log_group_name": "yum-logs",
            "log_stream_name": "{instance_id}",
            "timezone": "UTC"
          }
        ]
      }
    },
    "log_stream_name": "audit_stream",
    "force_flush_interval": 5
  }
}
EOF

#start the agent with the configuration above
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

systemctl enable amazon-cloudwatch-agent



