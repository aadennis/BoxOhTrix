Set-Location E:\Sandbox\PowerShell\BoxOhTrix
. .\Utilities.ps1

Set-StrictMode -Version latest



function Convert-DatesInFile($path) {
    Clear-Host
    Write-Status "Conversion starting"
    Validate-File $path
    Backup-File $path

    $VerboseFileContent = ""
    Get-Content $path | ForEach-Object {
        $record = $_
        $VerboseFileContent += Convert-DatesInRecord $record
    }
    $VerboseFileContent | Set-Content $path
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
        [string[]] $recordAsArray = @()
    }
    Process {
        foreach ($record in $recordSet) {
            Write-Verbose "Before: $record"
            $recordAsArray = [string[]] $record -split ","
            Write-Verbose "Before as array: $recordAsArray"
            $recordAsArray.Count

            foreach ($dateIndex in $datePosition) {
                $recordAsArray[$dateIndex-1] = Convert-Date $recordAsArray[$dateIndex-1]
            }

           Convert-ArrayToCSV $recordAsArray

           $cumulativeRecordsAsArray += $recordAsArray
        }
    }
    End {
        return $cumulativeRecordsAsArray
    }
}

#Test file 1
$fileToParseInMemory = 
@("Record 1,xNot much here,01/07/2010, Just here,03/08/2012,And a vowel please Rachel",
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

e