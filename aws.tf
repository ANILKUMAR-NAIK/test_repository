provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.session_key
}

resource "aws_instance" "example" {
  ami                    = "ami-0287a05f0ef0e9d9a"
  instance_type          = "t2.micro"
  #vpc_security_group_ids = ["vpc-074ca8053ec4b10c0.sg-06a4b027ddd2d2cd7"]
  user_data              = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF
  tags = {
    Name          = "terraform-learn-state-ec2"
    drift_example = "v1"
  }
  lifecycle {

    prevent_destroy = true
  }
}
