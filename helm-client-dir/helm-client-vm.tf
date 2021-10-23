// Create VM for Ansible client
// Configure the Google Cloud provider

provider "google" {
 credentials = file(var.key-location)
// credentials =  $(GOOGLE_CLOUD_KEYFILE_JSON)
 //project     = "vast-pad-319812"
 project     = var.project_id
 region      = var.region
}

// A single Compute Engine instance
resource "google_compute_instance" "gcp-instance" {
 // name         = "prografana-poc-vm-${random_id.instance_id.hex}"
 name = "helm-demo-tf"
 machine_type = "e2-medium"
 zone         = "asia-south1-c"
 tags = ["tf-notneeded"]
 labels = {
   "purpose" = "poc"
   "preserve" = "no"
 }
 boot_disk {
   initialize_params {
     image = "ubuntu-1804-bionic-v20210720"
   }
  }
// metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync"
  metadata_startup_script = file("helm-config.sh")

  network_interface {
    network = "default"
    access_config {
    }
  }
   metadata = {
   ssh-keys = "$var.os-user:${file("~/.ssh/id_rsa.pub")}"
   enable-oslogin = "TRUE"
  }
  scheduling {
    preemptible = "true"
    automatic_restart = "false"
    }
}

output "instance_ip_addr" {
  value = "${google_compute_instance.gcp-instance.hostname}"
}