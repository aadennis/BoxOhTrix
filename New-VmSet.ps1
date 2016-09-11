#New-VmSet
# Create a set of VMs using the Azure CLI

$errorLog = "c:\temp\configErrors.log"
$win2012R2Image = "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-20160812-en.us-127GB.vhd"
$username = "thomas"
$password = "Pathword22!"
$location = "`"East US`""
$vmSize = "`"Standard_F4`""
$vmSet = "MahWeb01", "MahWeb02", "MahDb"


$vmSet | ForEach-Object {
    $vmName = $_
    $vmCreateArgs = "vm create $vmName $win2012R2Image $username $password --location $location --vm-size $vmSize -r"
    Write-Output "Arguments passed to azure.cmd: $vmCreateArgs"
    Start-Process "azure.cmd" -ArgumentList $vmCreateArgs -NoNewWindow -RedirectStandardError $errorLog
}

Start-Sleep 10
Start-Process "notepad.exe" -ArgumentList $errorLog



