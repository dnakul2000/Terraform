resource "aws_instance" "deshmukh" {
 ami = "${lookup(var.amis,var.region)}"
 key_name = "${var.key_name}"
 vpc_security_group_ids = ["${aws_security_group.instance.id}"]
 source_dest_check = false
 instance_type = "t2.micro"
}



resource "aws_launch_configuration" "deshmukh_launch" {
  image_id = "${lookup(var.amis,var.region)}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.instance.id}"]
  key_name = "${var.key_name}"

}

resource "aws_autoscaling_group" "deshmukh_autoscale" {
  launch_configuration = "${aws_launch_configuration.deshmukh_launch.id}"
  availability_zones =["${data.aws_availability_zones.all.names}"]
  min_size = 2
  max_size = 10
  load_balancers = ["${aws_elb.deshmukh_elb.name}"]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "terraform"
    propagate_at_launch = true
  }
}

resource "aws_elb" "example" {
  name = "terraform-asg-example"
  security_groups = ["${aws_security_group.elb.id}"]
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}
