# terraform-lb-target-group-alarms
Terraform module to automate creating target group alarms

## Example usage
```terraform
module "terraform-lb-target-group-alarms" {
  source       = "github.com/TourRadar/terraform-lb-target-group-alarms"
  loadbalancer_arn     = aws_lb.test.arn
  target_group_arn     = aws_lb_target_group.test.arn
  actions      = ["snsarn etc"]
  alarm_prefix = "MyAlarmPrefix"
  tags = {
    Project = "SomeProject"
  }
}
```
