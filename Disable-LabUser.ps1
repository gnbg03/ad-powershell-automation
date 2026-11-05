# Offboarding: disable the account, remove all group memberships, move it to OU=Disabled, and date-stamp the description.
param([Parameter(Mandatory)][string]$Username)
New-ADOrganizationalUnit -Name "Disabled" -Path "DC=lab,DC=local" -ErrorAction SilentlyContinue
$u = Get-ADUser $Username -Properties MemberOf
Disable-ADAccount $u
foreach ($g in $u.MemberOf) { Remove-ADGroupMember -Identity $g -Members $u -Confirm:$false }
Move-ADObject $u.DistinguishedName -TargetPath "OU=Disabled,DC=lab,DC=local"
Set-ADUser $Username -Description "Disabled $(Get-Date -Format yyyy-MM-dd)"
Write-Output "$Username disabled, removed from groups, moved to Disabled OU"
