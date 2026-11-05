# Exports locked, disabled, and inactive (90+ days) user accounts to CSV files in the current folder.
Search-ADAccount -LockedOut -UsersOnly | Select Name, SamAccountName | Export-Csv locked.csv -NoTypeInformation
Search-ADAccount -AccountDisabled -UsersOnly | Select Name, SamAccountName | Export-Csv disabled.csv -NoTypeInformation
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 -UsersOnly | Select Name, LastLogonDate | Export-Csv inactive.csv -NoTypeInformation
