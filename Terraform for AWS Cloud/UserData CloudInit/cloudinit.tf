# Terraform is reading a file called init.cfg

data "template_file" "install_apache" {

  template = file("init.cfg")

}

# Prepare the context in init.cfg in a cloudinit understandable format
data "template_cloudinit_config" "install_apache_config" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.install_apache.rendered
  }

}
