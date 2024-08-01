$usrs = get-content "./userID.csv"
$list = @()

foreach($usr in $usrs){
  $user = Get-ADUser -Filter "EmployeeID -eq $usr" -Properties EmployeeID, SamAccountName -Server XXX.com

  $result = [PSCustomObject]@{
    Username = $user.SamAccountName
    Title = $user.EmployeeID
}
    $list += $result
}

$list | Out-File -FilePath "./IDresults.csv"
