output "target_response_time" {
  value = aws_cloudwatch_metric_alarm.target_response_time
}

output "healthy_host_count" {
  value = aws_cloudwatch_metric_alarm.healthy_host_count
}

output "http_code_target_4xx_count" {
  value = aws_cloudwatch_metric_alarm.http_code_target_4xx_count
}

output "http_code_target_5xx_count" {
  value = aws_cloudwatch_metric_alarm.http_code_target_5xx_count
}