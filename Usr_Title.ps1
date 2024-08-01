$usrs = get-content "./users.csv"
$list = @()

foreach($usr in $usrs){
  $user = Get-ADUser $usr -Properties Title, SamAccountName -Server XXX.com

  $result = [PSCustomObject]@{
    Username = $user.SamAccountName
    Title = $user.Title
}
    $list += $result
}

$list | Out-File -FilePath "./result.csv"

