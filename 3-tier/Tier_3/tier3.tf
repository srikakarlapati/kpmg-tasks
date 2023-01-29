resource "azurerm_sql_server" "sqlsrv" {
    name                         = "mysqlserver"
    resource_group_name          = azurerm_resource_group.my_rg.name
    location                     = azurerm_resource_group.my_rg.location
    version                      = "12.0"
    administrator_login          = "admin"
    administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}


resource "azurerm_sql_database" "sqldb" {
  name                             = "mysqldatabase"
  resource_group_name              = azurerm_resource_group.my_rg.name
  location                         = azurerm_resource_group.my_rg.location
  server_name                      = azurerm_sql_server.sqlsrv.name
  edition                          = "Standard"
  requested_service_objective_name = "S0"
  zone_redundant				   = true
}

resource "azurerm_private_endpoint" "plink" {
  name                = "sqlprivate-endpoint"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  subnet_id           = azurerm_subnet.app.id

  private_service_connection {
    name                           = "privateserviceconnection"
    private_connection_resource_id = azurerm_sql_server.sqlsrv.id
    subresource_names              = [ "sqlServer" ]
    is_manual_connection           = false
  }
  
resource "azurerm_private_dns_zone" "plink_dns_private_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.my_rg.name
}


data "azurerm_private_endpoint_connection" "plinkconnection" {
  name                = azurerm_private_endpoint.plink.name
  resource_group_name = azurerm_resource_group.my_rg.name
}

resource "azurerm_private_dns_a_record" "private_endpoint_a_record" {
  name                = azurerm_sql_server.sqlsrv.name
  zone_name           = azurerm_private_dns_zone.plink_dns_private_zone.name
  resource_group_name = azurerm_resource_group.my_rg.name
  ttl                 = 300
  records             = ["${data.azurerm_private_endpoint_connection.plinkconnection.private_service_connection.0.private_ip_address}"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "zone_to_vnet_link" {
  name                  = "pvt_zone_to_vnet_link"
  resource_group_name   = azurerm_resource_group.my_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.plink_dns_private_zone.name
  virtual_network_id    = azurerm_virtual_network.my_vnet.id
}
