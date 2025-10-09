function Get-StorageAccountSasToken {
  Param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string] $storageAccountName,
    [Parameter(Mandatory = $true, Position = 1)]
    [string] $containerName
  )

  $accountKey = az storage account keys list `
    --account-name $storageAccountName `
    --query '[0].value' `
    --output tsv

  if (-not $accountKey) {
    Write-Error 'Failed to retrieve account key'
    return
  }

  $expiry = (Get-Date).AddMonths(1).ToString('yyyy-MM-ddTHH:mm:ssZ')

  $sasToken = az storage container generate-sas `
    --account-name $storageAccountName `
    --account-key $accountKey `
    --name $containerName `
    --permissions r `
    --expiry $expiry `
    --https-only `
    --output tsv

  return $sasToken
}

function Set-StorageAccountSasToken {
  Param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string] $storageAccountName,
    [Parameter(Mandatory = $true, Position = 1)]
    [string] $containerName
  )
  $sasToken = Get-StorageAccountSasToken $storageAccountName $containerName
  
  gh secret set AZ_STORAGE_CONTAINER_SUPPORT_SAS `
    -R The-Strategy-Unit/nhp_project_information `
    -b $sasToken

  (Get-Content .Renviron) `
    -replace '^AZ_STORAGE_CONTAINER_SUPPORT_SAS=.*$', "AZ_STORAGE_CONTAINER_SUPPORT_SAS=$sasToken" `
  | Set-Content .Renviron
}

# load .Renviron file as environment variables
Get-Content .Renviron | ForEach-Object {
  $name, $value = $_.split('=')
  if ([string]::IsNullOrWhiteSpace($name) -or $name.Contains('#')) {
    # skip empty or comment line in ENV file
    return
  }
  Set-Content env:\$name $value
}

Set-StorageAccountSasToken $env:AZ_STORAGE_ACCOUNT $env:AZ_STORAGE_CONTAINER_SUPPORT