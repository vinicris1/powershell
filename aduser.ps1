if($args.Count -gt 1){
    Get-ADUser $args[0] -Server $args[1] -Properties * | Select -Property MemberOf,SamAccountName,DisplayName,Enabled,LockedOut,AccountLockoutTime,PasswordExpired,EmployeeID,Country,City,Manager,Department,Division,created,LastLogonDate,AccountExpirationDate,PasswordLastSet,LastBadPasswordAttempt,DistinguishedName,EmailAddress

}else{
    Get-ADUser $args[0] -Properties * | Select -Property MemberOf,SamAccountName,DisplayName,Enabled,LockedOut,AccountLockoutTime,PasswordExpired,EmployeeID,Country,City,Manager,Department,Division,created,LastLogonDate,AccountExpirationDate,PasswordLastSet,LastBadPasswordAttempt,DistinguishedName,EmailAddress
}