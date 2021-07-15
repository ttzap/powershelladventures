#Copy files from one server to another, apply modify permissions to folder owner 

$userList = @('usera','userb')
$rackSpaceU = "\\server-1\u-users$\"
$destinationAzure = "E:\USERS\"



ForEach ($item In $userList) { 

        Copy-Item $rackspaceU$item -destination $destinationAzure -Recurse -Force
        icacls "E:\users\$item" /grant $item":(OI)(CI)M" /T
        Write-Host -ForegroundColor Green "$($item) User Drive Moved to Azure!" 
        
    }
