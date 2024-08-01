$group = $args[0]
$resultList=@()

$groupmembers = Get-ADGroupMember -Identity $group -Recursive -Server XXX.com

foreach ($member in $groupmembers){
    $user = Get-ADUser -Identity $member.DistinguishedName -Properties Mail, SamAccountName -Server XXX.com

    $result = [PSCustomObject]@{
        Username = $user.SamAccountName
        Email = $user.Mail
    }

    $resultList += $result
}

$csv = $resultList | Format-Table -AutoSize 

$csv | Out-File -FilePath C:\temp\$group.csv

