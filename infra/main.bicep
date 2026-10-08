param location string = resourceGroup().location
var name = 'opspilot-${uniqueString(resourceGroup().id)}'

resource plan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: 'plan-${name}'
  location: location
  kind: 'linux'
  sku: { name: 'B1' }
  properties: { reserved: true }
}

resource app 'Microsoft.Web/sites@2024-04-01' = {
  name: name
  location: location
  kind: 'app,linux'
  properties: { serverFarmId: plan.id, httpsOnly: true }
}

resource web 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: app
  name: 'web'
  properties: {
    linuxFxVersion: 'NODE|22-lts'
    minTlsVersion: '1.2'
    ftpsState: 'Disabled'
  }
}

output appName string = app.name
