$rgName = "test-web-app-deploy-rg"
$location = "westeurope"
$appServicePlanName = "test-web-app-plan"
$appName = "test-web-app-maisak"
$tags = "project=test-deploy"

# Create resource group
az group create -n $rgname -l $location --tags $tags
# Create app service plan
az appservice plan create -n $appServicePlanName -g $rgName --sku F1 --tags $tags --is-linux
# create web app
az webapp create -n $appName -g $rgName --plan $appServicePlanName --runtime "DOTNETCORE:8.0" --tags $tags