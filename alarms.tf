locals {
  alarmLbTargetGroup = split(":", var.target_group_arn)[5]
  alarmLbName        = replace(split(":", var.loadbalancer_arn)[5], "loadbalancer/", "")
}


resource "aws_cloudwatch_metric_alarm" "healthy_host_count" {
  count               = var.healthy_host_count_enabled ? 1 : 0
  alarm_name          = "${var.alarm_prefix}: P1 LB health host count is too low for ${local.alarmLbTargetGroup} in ${local.alarmLbName}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.healthy_host_count_periods
  threshold           = var.healthy_host_count_threshold
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = var.healthy_host_count_period
  statistic           = "Minimum"
  alarm_description   = "Priority: P1 Health host count is too low"
  treat_missing_data  = var.healthy_host_count_treat_missing_data
  alarm_actions       = var.actions
  tags                = var.tags

  dimensions = {
    LoadBalancer = local.alarmLbName
    TargetGroup  = local.alarmLbTargetGroup
  }
}

resource "aws_cloudwatch_metric_alarm" "target_response_time" {
  for_each            = var.target_response_time_checks
  alarm_name          = "${var.alarm_prefix}: ${each.key} Target group resonse time is so slow for ${local.alarmLbTargetGroup} in ${local.alarmLbName}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.target_response_time_periods
  threshold           = each.value
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = var.target_response_time_period
  statistic           = "Average"
  alarm_description   = "Priority: ${each.key} Generating response from your application is too slow. It should not increase ${var.target_response_time_period}s"
  treat_missing_data  = var.target_response_time_treat_missing_data
  alarm_actions       = var.actions
  tags                = var.tags

  dimensions = {
    LoadBalancer = local.alarmLbName
    TargetGroup  = local.alarmLbTargetGroup
  }
}

resource "aws_cloudwatch_metric_alarm" "http_code_target_4xx_count" {
  for_each            = var.http_code_target_4xx_count_checks
  alarm_name          = "${var.alarm_prefix}: ${each.key} LB 4xx responses for ${local.alarmLbTargetGroup} in ${local.alarmLbName}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.http_code_target_4xx_count_periods
  threshold           = each.value
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = var.http_code_target_4xx_count_period
  statistic           = "Sum"
  alarm_description   = "Priority: ${each.key} Your loadbalancer returns 4xx errors. Please check access logs"
  treat_missing_data  = var.http_code_target_4xx_count_treat_missing_data
  alarm_actions       = var.actions
  tags                = var.tags

  dimensions = {
    LoadBalancer = local.alarmLbName
    TargetGroup  = local.alarmLbTargetGroup
  }
}

resource "aws_cloudwatch_metric_alarm" "http_code_target_5xx_count" {
  for_each            = var.http_code_target_5xx_count_checks
  alarm_name          = "${var.alarm_prefix}: ${each.key} LB 5xx responses for ${local.alarmLbTargetGroup} in ${local.alarmLbName}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.http_code_target_5xx_count_periods
  threshold           = each.value
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = var.http_code_target_5xx_count_period
  statistic           = "Sum"
  alarm_description   = "Priority: ${each.key} Your loadbalancer returns 5xx errors. In is critical error for application. Please check application logs"
  treat_missing_data  = var.http_code_target_5xx_count_treat_missing_data
  alarm_actions       = var.actions
  tags                = var.tags

  dimensions = {
    LoadBalancer = local.alarmLbName
    TargetGroup  = local.alarmLbTargetGroup
  }
}