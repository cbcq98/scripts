# Spam Email Blocking Script
Install-Module -Name ExchangeOnlineManagement

# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName "your-admin-email@example.com"

# Variables
$emailToBlock = "spam-email@example.com"
$ruleName = "Blocked Domains" # Name of your existing rule for blocked domains or addresses

# Fetch the existing rule to ensure it exists
$rule = Get-TransportRule -Identity $ruleName

if ($rule) {
    Write-Host "Rule '$ruleName' found. Adding the email address to the block list..." -ForegroundColor Green

    # Update the transport rule to include the email in the block list
    Set-TransportRule -Identity $ruleName -SenderAddressMatchesPatterns @($rule.SenderAddressMatchesPatterns + $emailToBlock)

    Write-Host "Email address '$emailToBlock' has been added to the block list of rule '$ruleName'." -ForegroundColor Green
} else {
    Write-Host "Rule '$ruleName' does not exist. Please create the rule first." -ForegroundColor Red
}

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false
