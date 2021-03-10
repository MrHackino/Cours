variable "image_name" {
  type    = string
  default = "azure_machine"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "azure-arm" "basic-example" {
    client_id = ""
    client_secret = ""
    subscription_id = ""
    tenant_id = ""

    managed_image_name = "${var.image_name}_${local.timestamp}"
    managed_image_resource_group_name = "PackerDeploy"
  
    os_type = "Linux"
    image_publisher = "Debian"
    image_offer = "debian-10"
    image_sku = "10"
  
    azure_tags = {
      dept = "r&d"
    }
  
    location = "westeurope"
    vm_size = "Standard_B1s"
  }
  
  build {
    sources = ["sources.azure-arm.basic-example"]
    provisioner "shell" {
      inline = [
        "sudo apt-get update",
        "sudo apt-get install -y gnupg2",
        "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367",
        "sudo apt install -y ansible"
      ]
    }
    provisioner "ansible-local" {
      playbook_file = "../ansible/zabbix_agent.yml"
      playbook_file = "../ansible/nextcloud.yml"
      role_paths = [
        "../ansible/roles/zabbix_agent/"
        "../ansible/roles/nexcloud/"
      ]
    }

    post-processor "manifest" {
      output = "manifest.json"
      strip_path = true
    }
    post-processor "shell-local" {
      script = "script_name.sh"
    }
  }
