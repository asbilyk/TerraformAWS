provider "aws" {
  region = "eu-west-1"
}
resource "aws_instance" "web" {
  ami = "ami-e4515e0e"
  instance_type = "t2.micro"
  launch_configuration = "${aws_launch_configuration.example.id}"
  min_size = 2
  max_size = 10
  health_check_grace_period = 900
  tags {
    Name = "web"
  }
  user_data = <<-EOF
              #!/bin/bash
             hostname > index.html
             nohup busybox httpd -f -p "${var.server_port}" &
             EOF
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 15
    target = "HTTP:${var.server_port}/"
  }
   
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.server_port}"
    instance_protocol = "http"
  }        
}

