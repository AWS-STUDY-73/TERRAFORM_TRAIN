# Create Launch Templete
resource "aws_launch_template" "launch_template_asg" {
  name                   = "launch_template_asg"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
}


# Create Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 2
  launch_configuration      = aws_launch_template.launch_template_asg.name
}

# CPU Based Scaling
resource "aws_autoscaling_policy" "cpu" {
  name                   = "cpu"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 50
  cooldown               = 300
  policy_type            = "TargetTrackingScaling"
  
  target_tracking_configuration {
    predefined_metric_specification {
      #target_value = 50.0
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}