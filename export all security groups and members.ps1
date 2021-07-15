$Groups = (Get-AdGroup -filter * -SearchBase "OU=AAA-Sites,DC=BBB,DC=local" | Where {$_.name -like "**"} | select name -expandproperty name)


$Table = @()

$Record = [ordered]@{
"Group Name" = ""
"Name" = ""
"Username" = ""
}



Foreach ($Group in $Groups)
{

$Arrayofmembers = Get-ADGroupMember -identity $Group | select name,samaccountname

foreach ($Member in $Arrayofmembers)
{
$Record."Group Name" = $Group
$Record."Name" = $Member.name
$Record."UserName" = $Member.samaccountname
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord

}

}

$Table | export-csv "C:\scripts\results\SecurityGroups.csv" -NoTypeInformation
