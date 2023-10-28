terraform {
  cloud {
    organization = "inva-personal"

    workspaces {
      name = "homelab"
    }
  }
}
