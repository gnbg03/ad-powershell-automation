# Creates users from new-hires.csv in OU=Employees and adds them to the group listed in the CSV.
$Password = Read-Host -AsSecureString "Initial password"
Import-Csv .\new-hires.csv | ForEach-Object {
    $sam = $_.Username
    if (Get-ADUser -Filter "SamAccountName -eq '$sam'") { Write-Warning "$sam already exists"; return }
    New-ADUser -Name "$($_.FirstName) $($_.LastName)" -GivenName $_.FirstName -Surname $_.LastName `
        -SamAccountName $sam -UserPrincipalName "$sam@lab.local" `
        -Path "OU=Employees,DC=lab,DC=local" -AccountPassword $Password `
        -ChangePasswordAtLogon $true -Enabled $true
    if ($_.Group) { Add-ADGroupMember -Identity $_.Group -Members $sam }
    Write-Output "Created $sam"
}
