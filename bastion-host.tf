resource "aws_instance" "vprofile-bastion" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.vprofilekey.key_name
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  count = var.instance_count
  security_groups = [aws_security_group.vprofile-bastion-sg.id]

  tags = {
    Name = "vprofile-bastion"
    PROJECT = "vprofile"
  }

  provisioner "file" {
    content = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.vprofile-rds.address, dbuser = var.db_username, dbpass = var.db_password})
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-dbdeploy.sh"
    ]
  }

  connection {
    user = var.USERNAME
    private_key = var.PRIV_KEY
    host = self.public_ip
  }
  depends_on = [aws_db_instance.vprofile-rds]
}