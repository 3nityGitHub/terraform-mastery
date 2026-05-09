resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-key-${var.environment}"
  public_key = file("~/.ssh/talium.pub")

  tags = {
    Name = "${var.project_name}-key-${var.environment}"
  }
}
