variable "image_name" {
  type    = string
  default = "azure_machine"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "azure-arm" "basic-example" {
    client_id = "c1e07fb8-c40b-4ceb-a315-48d93da574cf"
    client_secret = "EV1KbxTVxTmr0cRcgDxR.KFRl5pvFABZ-s"
    subscription_id = "8e3ba344-f521-4a73-bc0e-bc3c4cb0de16"
    tenant_id = "190ce420-b157-44ae-bc2f-69563baa5a3b"

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