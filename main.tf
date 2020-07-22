provider "google" {
  project = var.project_name
  region  = var.region_name
  zone    = var.zone_name
}

resource "google_compute_disk" "google-minecraft-disk" {
  name  = "google-minecraft-disk"
  type  = "pd-ssd"
  zone  = var.region_name
  size = "20"
}

resource "google_compute_attached_disk" "google-minecraft-disk" {
  disk     = google_compute_disk.google-minecraft-disk.id
  instance = google_compute_instance.vm_instance.id
}

resource "google_compute_firewall" "gh-9564-firewall-externalssh" {
  name    = "gh-9564-firewall-externalssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "25565"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["externalssh"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = var.machine_size

  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }
  
  # the below sets the instance to preemtible however we need to manage the disk state better...
  # scheduling {
  #  preemptible = true
  #  automatic_restart = false
  # }

  metadata = {
    ssh-keys = "${var.username}:${file(var.private_key_path)}"
  }

  # We connect to our instance via Terraform and remotely executes our script using SSH
  provisioner "remote-exec" {
    script = var.script_path

    connection {
      type        = "ssh"
      user        = var.username
      host        = "${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
      private_key = file(var.private_key_path)
    }
  }

  # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
  depends_on = ["google_compute_firewall.gh-9564-firewall-externalssh"]

  network_interface {
    network = "default"

    access_config {
      # Ephemeral
    }
  }
}
