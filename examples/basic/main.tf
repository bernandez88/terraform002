module "appservice" {
  source = "../../"
  subscription_name ="PortalSV"
  location = "eastus"
  tags = {
      applicationname       = "paasappservice",
      environment           = "nonprod",
      owneremail            = "bernandez88@gmail.com"
      owner                 = "bernandez88"
      srcr                  = "srcr123"
      apm                   = "apm123"
      notificationdistlist  = "bernandez88@gmail.com"
      trproductid           = "trproductid123"
      hubinstance           = "hubinstance123"
  }
}