# resource "aws_instance" "frontend" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "frontend"
#   }
# }
#
# resource "aws_route53_record" "frontend" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "frontend-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "mongodb" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "mongodb"
#   }
# }
#
# resource "aws_route53_record" "mongodb" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "mongodb-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.mongodb.private_ip]
# }
#
#
#
# resource "aws_instance" "catalogue" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "catalogue"
#   }
# }
#
# resource "aws_route53_record" "catalogue" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "catalogue-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.catalogue.private_ip]
# }
#
# resource "aws_instance" "redis" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "redis"
#   }
# }
#
# resource "aws_route53_record" "redis" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "redis-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.redis.private_ip]
# }
#
#
# resource "aws_instance" "user" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "user"
#   }
# }
#
# resource "aws_route53_record" "user" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "user-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.user.private_ip]
# }
#
# resource "aws_instance" "cart" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "cart"
#   }
# }
#
# resource "aws_route53_record" "cart" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "cart-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.cart.private_ip]
# }
#
#
# resource "aws_instance" "mysql" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "mysql"
#   }
# }
#
# resource "aws_route53_record" "mysql" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "mysql-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.mysql.private_ip]
# }
#
# resource "aws_instance" "shipping" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "shipping"
#   }
# }
#
# resource "aws_route53_record" "shipping" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "shipping-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.shipping.private_ip]
# }
#
# resource "aws_instance" "rabbitmq" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "rabbitmq"
#   }
# }
#
# resource "aws_route53_record" "rabbitmq" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "rabbitmq-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.rabbitmq.private_ip]
# }
#
#
# resource "aws_instance" "payment" {
#   ami           = "ami-0220d79f3f480ecf5"
#   instance_type = "t3.small"
#   vpc_security_group_ids = [ "sg-0861e09dd92fe1871" ]
#
#   tags = {
#     Name = "payment"
#   }
# }
#
# resource "aws_route53_record" "payment" {
#   zone_id = "Z016642425URABBZ7FJPB"
#   name    = "payment-dev"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.payment.private_ip]
# }


resource "aws_instance" "instances" {
  for_each      = var.components
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = each.key
  }

}

resource "aws_route53_record" "a-records" {
  for_each      = var.components
  zone_id = var.zone_id
  name    = "${each.key}-dev"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instances[each.key].private_ip]
}

resource "null_resource" "ansible" {

  depends_on = [
    aws_instance.instances,
    aws_route53_record.a-records
  ]


  for_each      = var.components

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = aws_instance.instances[each.key].private_ip
    }

    inline = [
      "sudo dnf install python3.13-pip -y",
      "sudo pip3.11 install ansible",
      "ansible-pull -i localhost, -U https://github.com/Swetha-N169/automated-ansible-templates.git main.yml -e component=${each.key} -e env=dev"
    ]

  }

}