[![Build and package](https://github.com/maisak/actions/actions/workflows/build.yml/badge.svg)](https://github.com/maisak/actions/actions/workflows/build.yml)
[![Deploy](https://github.com/maisak/actions/actions/workflows/deploy.yml/badge.svg)](https://github.com/maisak/actions/actions/workflows/deploy.yml)
[![Package](https://github.com/maisak/actions/actions/workflows/package.yml/badge.svg)](https://github.com/maisak/actions/actions/workflows/package.yml)
# Intro

This repository contains a simple web application that can be deployed to Azure App Service using Github Actions.
There are two actions defined in `.github/workflows` directory:
- `build.yml` - builds the application and sets version in `appsettings.json` file.
- `deploy.yml` - publishes the application to Azure App Service;

Both actions are triggered manually.

To facilitate the deployment process, two scripts are provided:
- `create-azure-resources.ps1` - creates Azure resources required for the deployment;
- `delete-azure-resources.ps1` - deletes Azure resources created by `create-azure-resources.ps1` script.


# Quickstart

### Create Azure resources

```powershell
az login
cd scripts
./create-azure-resources.ps1
```

### Github configuration

1. Download publish profile from Azure App Service;

![image](https://github.com/user-attachments/assets/3aa0921a-3db3-4b96-854f-3208280f4407)

  
2. Copy contents of publish profile to new Github secret named `AZURE_DEMO_PUBLISH_PROFILE`;

![image](https://github.com/user-attachments/assets/081dcfbe-4ebe-40b8-865b-30682ec0b5b9)

3. Run Github action named 'Build' (if it wasn't run before);
4. Run Github action named 'Deploy' (requires an artifact generated by step #3).

### Clean up Azure resources

```powershell
cd scripts
./delete-azure-resources.ps1
```
# Shared library

Another project is a 'SharedPackage' that is packed into a nuget package and published to Github Packages.

### To manually build the package:

Make sure package project has all the settings needed in `.csproj` file.

```xml  
<PackageId>AwesomePrivatePackage</PackageId>  
<Version>1.0.6</Version>  
<Authors>Anthony Maisak</Authors>  
<Description>A sample class library</Description>  
<PackageTags>sample</PackageTags>  
<RepositoryUrl>https://github.com/maisak/actions</RepositoryUrl>  
```  
Pack it

```powershell  
cd SharedPackage  
dotnet build  
dotnet pack -c Release  
```  

Publish it

```powershell  
dotnet nuget add source --username maisak --password <PAT> --store-password-in-clear-text --name github-maisak "https://nuget.pkg.github.com/maisak/index.json"  
dotnet nuget push .\bin\Release\AwesomePrivatePackage.1.0.6.nupkg -s github-maisak
```
