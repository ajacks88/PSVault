function Get-VaultKV1Secret 
{
    param 
    (
        $VaultURL = '',
        $SecretPath = '',
        $AuthToken = ''
    )

    $Headers = @{'X-Vault-Token' = $AuthToken}
    $URI = $VaultURL + '/v1/' + $SecretPath

    $Response = (Invoke-RestMethod -Uri $URI -Headers $Headers).data

    return $Response

}

function Get-VaultKV2Secret 
{
    param 
    (
        $VaultURL = '',
        $SecretEngineName = '',
        $SecretName= '',
        $AuthToken = ''
    )

    $Headers = @{'X-Vault-Token' = $AuthToken}
    $URI = $VaultURL + '/v1/' + $SecretEngineName + '/data/' + $SecretName

    $Response = (Invoke-RestMethod -Uri $URI -Headers $Headers).data.data

    return $Response

}

function New-VaultKV2Secret 
{
    param 
    (
        $VaultURL = '',
        $SecretEngineName = '',
        $SecretName = '',
        $SecretData = '',
        $AuthToken = ''
    )

    $Headers = @{'X-Vault-Token' = $AuthToken}
    $URI = $VaultURL + '/v1/' + $SecretEngineName + '/data/' + $SecretName

    $Secret = @{
        "options" = @{
            "cas"= 0
        }
        "data" = $SecretData
      }
    $Body = $Secret | ConvertTo-Json

    $Response = Invoke-RestMethod -Uri $URI -Method Post -Body $Body -Headers $Headers

    return $Response

}

function Update-VaultKV2Secret
{
    param 
    (
        $VaultURL = '',
        $SecretEngineName = '',
        $SecretName = '',
        $SecretData = '',
        $AuthToken = ''
    )
    $Headers = @{'X-Vault-Token' = $AuthToken}
    $URI = $VaultURL + '/v1/' + $SecretEngineName + '/data/' + $SecretName

    $Secret = @{
        "data" = $SecretData
      }
    $Body = $Secret | ConvertTo-Json

    $Response = Invoke-RestMethod -Uri $URI -Method Post -Body $Body -Headers $Headers

    return $Response

}

function Remove-VaultKV2Secret
{
    param 
    (
        $VaultURL = '',
        $SecretEngineName = '',
        $SecretName = '',
        $AuthToken = ''
    )
    $Headers = @{'X-Vault-Token' = $AuthToken}
    $URI = $VaultURL + '/v1/' + $SecretEngineName + '/metadata/' + $SecretName
    $Response = Invoke-RestMethod -Uri $URI -Method Delete -Body $Body -Headers $Headers

    return $Response

}