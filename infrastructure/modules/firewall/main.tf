resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  zones               = var.zones
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "sca-project"
}

resource "azurerm_firewall" "main" {
  name                = var.fw_name
  resource_group_name = var.resource_group_name
  location            = var.location
  zones               = var.zones
  threat_intel_mode   = var.threat_intel_mode
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  firewall_policy_id  = azurerm_firewall_policy.policy.id
  tags                = var.tags


  ip_configuration {
    name                 = "fw_ip_config"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  lifecycle {
    ignore_changes = [
      tags
      
    ]
  }
}

resource "azurerm_firewall_policy" "policy" {
  name                = "${var.fw_name}Policy"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_firewall_policy_rule_collection_group" "policies" {
  name               = "AksEgressPolicyRuleCollectionGroup"
  firewall_policy_id = azurerm_firewall_policy.policy.id
  priority           = 100

  application_rule_collection {
    name     = "ApplicationRules"
    priority = 300
    action   = "Allow"

    rule {
      name             = "AllowMicrosoftFqdns"
      source_addresses = ["*"]

      destination_fqdns = [
        "*.cdn.mscr.io",
        "mcr.microsoft.com",
        "*.data.mcr.microsoft.com",
        "management.azure.com",
        "vault.azure.net",
        "login.microsoftonline.com",
        "acs-mirror.azureedge.net",
        "dc.services.visualstudio.com",
        "*.opinsights.azure.com",
        "*.oms.opinsights.azure.com",
        "*.microsoftonline.com",
        "*.monitoring.azure.com",
        "data.policy.core.windows.net",
        "store.policy.core.windows.net",
        "*.dp.kubernetesconfiguration.azure.com"
      ]

      protocols {
        port = "80"
        type = "Http"
      }

      protocols {
        port = "443"
        type = "Https"
      }
    }

    rule {
      name             = "AllowFqdnsForOsUpdates"
      source_addresses = ["*"]

      destination_fqdns = [
        "download.opensuse.org",
        "security.ubuntu.com",
        "ntp.ubuntu.com",
        "changelogs.ubuntu.com",
        "azure.archive.ubuntu.com",
        "packages.microsoft.com",
        "snapcraft.io"
      ]

      protocols {
        port = "80"
        type = "Http"
      }

      protocols {
        port = "443"
        type = "Https"
      }
    }
    
    rule {
      name             = "AllowImagesFqdns"
      source_addresses = ["*"]

      destination_fqdns = [
        "auth.docker.io",
        "registry-1.docker.io",
        "production.cloudflare.docker.com"
      ]

      protocols {
        port = "80"
        type = "Http"
      }

      protocols {
        port = "443"
        type = "Https"
      }
    }

    rule {
      name             = "AllowBing"
      source_addresses = ["*"]

      destination_fqdns = [
        "*.bing.com"
      ]

      protocols {
        port = "80"
        type = "Http"
      }

      protocols {
        port = "443"
        type = "Https"
      }
    }

    rule {
      name             = "AllowGoogle"
      source_addresses = ["*"]

      destination_fqdns = [
        "*.google.com"
      ]

      protocols {
        port = "80"
        type = "Http"
      }

      protocols {
        port = "443"
        type = "Https"
      }
    }
  }

  network_rule_collection {
    name     = "NetworkRules"
    priority = 200
    action   = "Allow"

    rule {
      name                  = "Internet"
      source_addresses      = ["*"]
      destination_ports     = ["*"]
      destination_addresses = ["*"]
      protocols             = ["TCP"]
    }
    
    rule {
      name                  = "Time"
      source_addresses      = ["*"]
      destination_ports     = ["123"]
      destination_addresses = ["*"]
      protocols             = ["UDP"]
    }

    rule {
      name                  = "DNS"
      source_addresses      = ["*"]
      destination_ports     = ["53"]
      destination_addresses = ["*"]
      protocols             = ["UDP"]
    }

    rule {
      name                  = "ServiceTags"
      source_addresses      = ["*"]
      destination_ports     = ["*"]
      destination_addresses = [
        "AzureContainerRegistry",
        "MicrosoftContainerRegistry",
        "AzureActiveDirectory"
      ]
      protocols             = ["Any"]
    }
  }

  nat_rule_collection {
    name     = "nat_rule_collection"
    priority = 100
    action   = "Dnat"
    rule {
      name                = "nat_rule_collection_rule_https"
      protocols           = ["TCP"]
      source_addresses    = ["*"]
      destination_address = azurerm_public_ip.public_ip.ip_address
      destination_ports   = ["443"]
      translated_address  = var.ingress_ip
      translated_port     = "443"
    }

    rule {
      name                = "nat_rule_collection_rule_http"
      protocols           = ["TCP"]
      source_addresses    = ["*"]
      destination_address = azurerm_public_ip.public_ip.ip_address
      destination_ports   = ["80"]
      translated_address  = var.ingress_ip
      translated_port     = "80"
    }
  }

  lifecycle {
    ignore_changes = [
      application_rule_collection,
      network_rule_collection,
      nat_rule_collection
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_firewall.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "AzureFirewallApplicationRule"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  log {
    category = "AzureFirewallNetworkRule"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  log {
    category = "AzureFirewallDnsProxy"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "public_ip_settings" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_public_ip.public_ip.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "DDoSProtectionNotifications"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  log {
    category = "DDoSMitigationFlowLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  log {
    category = "DDoSMitigationReports"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }
}