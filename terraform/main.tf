data "cloudflare_user" "me" {}

data "cloudflare_accounts" "my_accounts" {
  name = data.cloudflare_user.me.email
}

data "cloudflare_zone" "main" {
  name       = var.main_domain
  account_id = data.cloudflare_accounts.my_accounts.accounts[0].id
}

resource "cloudflare_email_routing_settings" "main" {
  zone_id = data.cloudflare_zone.main.id
  enabled = "true"
}

resource "cloudflare_email_routing_address" "main" {
  account_id = data.cloudflare_accounts.my_accounts.accounts[0].id
  email      = data.cloudflare_user.me.email
}

resource "cloudflare_email_routing_catch_all" "catchall" {
  zone_id = data.cloudflare_zone.main.id
  name    = "Catch-All"
  enabled = true

  matcher {
    type = "all"
  }

  action {
    type  = "forward"
    value = [resource.cloudflare_email_routing_address.main.email]
  }
}

resource "cloudflare_email_routing_rule" "main" {
  zone_id = data.cloudflare_zone.main.id
  name    = "main"
  enabled = true

  matcher {
    type  = "literal"
    field = "to"
    value = "me@${data.cloudflare_zone.main.name}"
  }

  action {
    type  = "forward"
    value = [resource.cloudflare_email_routing_address.main.email]
  }
}
