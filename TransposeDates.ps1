cd c:\Sandbox\PowerShell
. .\Utilities.ps1

Set-StrictMode -Version latest



function Convert-DatesInFile($path) {
    Clear-Host
    Write-Status "Conversion starting"
    Validate-File $path
    Backup-File $path

    $outputFileContent = ""
    Get-Content $path | ForEach-Object {
        $record = $_
        $outputFileContent += Convert-DatesInRecord $record
    }
    $outputFileContent | Set-Content $path
    Write-Status "Conversion complete"
}





# Given a set of csv (right now) delimited records, and a statement about the positions of date fields in each
# record, invert the dates (US -> GB, GB -> US), and return the set
function Convert-DatesInMemory {
    [CmdletBinding()]
    Param (
        [string[]] $recordSet,
        [int[]] $datePosition
    )

    Begin {
        $cumulativeRecordsAsArray = @()
    }
    Process {
        foreach ($record in $recordSet) {
            Write-Host "Before: $record"
            $recordAsArray = $record -split ","
            Write-Host "Before as array: $recordAsArray"
            $recordAsArray.Count

            foreach ($dateIndex in $datePosition) {
                $recordAsArray[$dateIndex-1] = Convert-Date $recordAsArray[$dateIndex-1]
            }
           Write-Host "After as array: $recordAsArray"

           foreach ($ff in $recordAsArray) {
            Write-Host "a: $ff"
           }

           $recordAsArray.GetType()
           $uuu = $recordAsArray | Select-Object | ConvertTo-Csv 
           $uuu

           $cumulativeRecordsAsArray += $recordAsArray
        }
    }
    End {
        return $cumulativeRecordsAsArray
    }
}

#Test file 1
$fileToParseInMemory = 
@("Record 1,Not much here,01/07/2010, Just here,03/08/2012,And a vowel please Rachel",
"Record    2,Quite a lot here         ,01/06/2011,Over there,22/12/2015, Just the consonant please Rache")

#$fileToParseInMemory
$fileToParseInMemory.Count

#fail...
#Position does not exist
#Convert-DatesInFile2 -recordSet $fileToParseInMemory -datePosition 13, 15 -Verbose
#Position1 is not a date
#Convert-DatesInFile2 -recordSet $fileToParseInMemory -datePosition 2, 5 -Verbose


# Execute this...
#Convert-DatesInFile -path "c:\sandbox\powershell\BasicFile.csv"


#pass
$xxx = Convert-DatesInMemory -recordSet $fileToParseInMemory -datePosition 3, 5 -Verbose

$xxx.Count

return

#fail...
$ss = Convert-Date "22/12/2015x" -Verbose
$ss = Convert-Date "22x12/2015" -Verbose
$ss = Convert-Date "22/12x2015" -Verbose

#pass... (but still naive for now)

$ss
$ss = Convert-Date "03/12/2015" -Verbose