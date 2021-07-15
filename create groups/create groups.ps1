import-module activedirectory

$siteName = "CFV-"
$csv = Import-Csv -Path "c:\scripts\groups.csv"
$locationOU = "OU="+$siteName+"Groups,OU=CCC,OU=AAA-Sites,DC=BBB,DC=local"

ForEach ($item In $csv) { 
        $formatted_group = $siteName+$item.GroupName
        $create_group = New-ADGroup -Name $formatted_group -GroupCategory $item.GroupCategory -groupScope $item.GroupScope -Path $locationOU
        Write-Host -ForegroundColor Green "Group $($formatted_group) created!" 
        
       if ($item -match 'nurse') {
         Add-ADGroupMember -Identity $siteName"Nurses" -Members $formatted_group
         Write-Host -ForegroundColor Yellow "Added to Nurses group"
       } 
       else {
         Add-ADGroupMember -Identity $siteName"Staff" -Members $formatted_group  
         Write-Host -ForegroundColor White "Added to Staff group"
      }
    }

Remove-ADGroupMember -Identity $siteName"Nurses" -Member $siteName"Nurses" -Confirm:$false
Remove-ADGroupMember -Identity $siteName"Staff" -Member $siteName"Staff" -Confirm:$false
Add-ADGroupMember -Identity $siteName"Staff" -Members $siteName"Nurses"

