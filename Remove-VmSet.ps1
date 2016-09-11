#Remove-VmSet
# Delete a set of VMs using the Azure CLI

$errorLog = "c:\temp\removalErrors.log"
$win2012R2Image = "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-20160812-en.us-127GB.vhd"
$username = "thomas"
$password = "Pathword22!"
$location = "`"East US`""
$vmSet = "MahWeb01", "MahWeb02", "MahDb"

$vmSet | ForEach-Object {
    $vmName = $_
    $vmCreateArgs = "vm delete $vmName --blob-delete --quiet"
    Write-Output "Arguments passed to azure.cmd: [$vmCreateArgs]"
    Start-Process "azure.cmd" -ArgumentList $vmCreateArgs -NoNewWindow -RedirectStandardError $errorLog
}



