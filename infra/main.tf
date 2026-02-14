module "vpc" {
  source      = "terraform-do-modules/vpc/digitalocean"
  version     = "1.0.0"
  name        = var.name
  environment = var.environment
  region      = var.region
  ip_range    = var.vpc_cidr
}

module "droplet" {
  source  = "terraform-do-modules/droplet/digitalocean"
  version = "1.0.4"

  name         = var.name
  environment  = var.environment
  region       = var.region
  droplet_size = var.droplet_size
  image_name   = var.droplet_image
  ipv6         = var.enable_ipv6
  vpc_uuid     = module.vpc.id
  ssh_keys = {
    main = {
      public_key = var.ssh_key
    }
  }
}
