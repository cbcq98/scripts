# Set threshold in days
$threshold = 30
$cutoffDate = (Get-Date).AddDays(-$threshold)

# Get user profiles excluding system ones
$userProfiles = Get-CimInstance Win32_UserProfile | Where-Object {
    $_.Special -eq $false -and $_.LastUseTime -ne $null -and ([DateTime]::FromFileTime($_.LastUseTime) -lt $cutoffDate)
}

# Remove profiles
foreach ($profile in $userProfiles) {
    Remove-CimInstance -InputObject $profile
    Write-Output "Removed profile: $($profile.LocalPath)"
}