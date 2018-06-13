resource "aws_instance" "deshmukh" {
 ami = "${lookup(var.amis,var.region)}"
 key_name = "${var.key_name}"
 vpc_security_group_ids = ["${aws_security_group.instance.id}"]
 source_dest_check = false
 instance_type = "t2.micro"
}


resource "aws_autoscaling_group" "deshmukh_autoscale"
