resource "google_container_cluster" "primary" {
  name     = "helm-gke-cluster"
  location = "asia-south1-c"
  
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_service_account" "default" {
  account_id   = "helm-poc-service-account-id"
  display_name = "Service Account"
}
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "helm-node-pool"
  location   = "asia-south1-c"
  cluster    = google_container_cluster.primary.name
  node_count = 2
  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}