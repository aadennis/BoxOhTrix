cd C:\sandbox\PowerShell


function Unlock-Reference ($reference) {
    ([System.Runtime.InteropServices.Marshal]::ReleaseComObject(
        [System.__ComObject] $reference) -gt 0)
    [System.GC]::WaitForPendingFinalizers()
}

function Show-WorkSheet 
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        $spreadSheet
    ) 
    if (! (Test-Path -Path $spreadSheet)) {
        Write-Host "Could not find $spreadSheet. Exiting"
        return
    }
    $excel = New-Object -ComObject excel.application
    $excel.visible = $false
    $workbook = $excel.WorkBooks.Open($spreadSheet)

    ForEach ($workSheet in $workbook.Worksheets) {
        Write-Host($workSheet.Name)
    }

    $dummy = Unlock-Reference($workSheet) 
    $dummy = Unlock-Reference($workbook)
    $dummy = Unlock-Reference($excel)
}


