Start-Transcript -Path C:\WindowsAzure\Logs\logon.txt -Append
# logon task
$AppID = $env:AppID
$AppSecret = $env:AppSecret
$DeploymentID = $env:DeploymentID
 
#if we need to login to the Azure uisng CLI or poweshell command we need to user
 
. C:\LabFiles\AzureCreds.ps1

$userName = $AzureUserName
$password = $AzurePassword
$subscriptionId = $AzureSubscriptionID
$TenantID = $AzureTenantID

 
$securePassword = $AppSecret | ConvertTo-SecureString -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $AppID, $SecurePassword
 
# If we are using Connect-AzAccount we need to use Login-AzAccount
Connect-AzAccount -ServicePrincipal -Credential $cred -Tenant $AzureTenantID | Out-Null

$accountName = ("agent-{0}" -f $DeploymentID).ToLower()
$acct = Get-AzResource -ResourceType "Microsoft.CognitiveServices/accounts" -Name $accountName -ErrorAction Stop

$projectName = "agentic-ai-project"
$projectScope = "$($acct.ResourceId)/projects/$projectName"
$role = "Azure AI User"

function Ensure-Role {
    param(
        [string]$Scope,
        [string]$RoleName,
        [string]$Upn
    )
    $existing = Get-AzRoleAssignment -Scope $Scope -ErrorAction SilentlyContinue |
        Where-Object { $_.RoleDefinitionName -eq $RoleName -and $_.SignInName -eq $Upn }
    if (-not $existing) {
        try {
            New-AzRoleAssignment -Scope $Scope -RoleDefinitionName $RoleName -SignInName $Upn -ErrorAction Stop | Out-Null
            Write-Host "Assigned '$RoleName' to $Upn at:`n$Scope"
        } catch {
            # fallback: resolve ObjectId
             $objId = (Get-AzADUser -UserPrincipalName $Upn -ErrorAction SilentlyContinue).Id
            if ($objId) {
                New-AzRoleAssignment -Scope $Scope -RoleDefinitionName $RoleName -ObjectId $objId -ErrorAction Stop | Out-Null
                Write-Host "Assigned '$RoleName' (via ObjectId) to $Upn at:`n$Scope"
            } else {
                 Write-Warning "Could not resolve $Upn in Entra ID; RBAC '$RoleName' at $Scope not assigned."
            }
        }
    } else {
        Write-Host "'$RoleName' already assigned to $Upn at:`n$Scope"
    }
}
# Required for Agents API (Microsoft.CognitiveServices/accounts/AIServices/agents/write)
Ensure-Role -Scope $projectScope -RoleName $role -Upn $AzureUserName

# Optional niceties (won't hurt if they already exist)
Ensure-Role -Scope $acct.ResourceId -RoleName "Reader" -Upn $AzureUserName
$aiName = ("agent-insights-{0}" -f $DeploymentID)
$appInsights = Get-AzResource -ResourceType "Microsoft.Insights/components" -Name $aiName -ErrorAction SilentlyContinue
if ($appInsights) {
    Ensure-Role -Scope $appInsights.ResourceId -RoleName "Reader" -Upn $AzureUserName
}


# Variables
$storageAccountName = ("aistorage{0}" -f $DeploymentID).ToLower()
$containerName      = "datasets"
$localDirectory     = "C:\datasets"
$rg = "agenticai"

$storage_account_key = (Get-AzStorageAccountKey -ResourceGroupName $rg -AccountName $storageAccountName )[0].Value

# Authenticate and get the storage context
$context = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storage_account_key

# Get all files from the specified local directory
Get-ChildItem -Path $localDirectory -File | ForEach-Object {
    $filePath = $_.FullName
    $blobName = $_.Name  # The name of the blob will be the same as the file name

    Write-Host "Uploading $blobName..."
    Set-AzStorageBlobContent -File $filePath -Container $containerName -Blob $blobName -Context $context
    Write-Host "$blobName uploaded successfully!"
}

pip install agent-framework --pre

pip install python-dotenv

Unregister-ScheduledTask -TaskName "Setup" -Confirm:$false 