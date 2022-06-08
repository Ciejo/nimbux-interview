resource "aws_instance" "nginx" {
    ami = var.ami_nginx
    instance_type = var.instance_type
    
    tags = {
        Name = "Nginx server"
    }
    security_groups = ["${aws_security_group.servers-sg.id}"]
	subnet_id = aws_subnet.private.0.id
    user_data = "${file("user_data.sh")}"
}

resource "aws_instance" "apache" {
    ami = var.ami_apache
    instance_type = var.instance_type
    
    tags = {
        Name = "Apache server"
    }
    security_groups = ["${aws_security_group.servers-sg.id}"]
	subnet_id = aws_subnet.private.1.id
    user_data = "${file("user_data2.sh")}"
}
