resource "aws_instance" "web" {
    instance_type = "t2.micro"
    ami ="ami-007855ac798b5175e"
    subnet_id = "subnet-0d437a12f81c01aad"
    key_name = "key-north-virginia"
}



// terraform import aws_instance.web  i-0939a85070dd9bd75 ( existing instance id)