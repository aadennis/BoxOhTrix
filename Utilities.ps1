﻿# A set of utilities. 
# To be in here, a function must have no dependencies on other application code.

Set-StrictMode -Version latest

#----------------- Logging ---------------------------------
# Write a message to the command line, formatted as black on white
function Write-Status ($message, $value) {
    if ($value -ne $null) {
        $value = "[" + $value + "]"
    }
    Write-Host "$(Get-Date) [$message] $value" -BackgroundColor White -ForegroundColor Black
}

#----------------- File actions ---------------------------------

# Backup a file to the user temp directory using a guid. Suffix is csv right now.
function Backup-File($path) {
  $id = [System.Guid]::NewGuid()
    $backupFile = "$env:temp\$id.csv"
    Write-Status "Backup file" $backupFile
    Copy-Item $path $backupFile
}

# Validate file just based on path existence right now
function Validate-File ($path) {
    if ($(Test-Path $path) -ne $true) {
        Write-Status "File [$path] was not found"
        exit
    }

    Write-Status "Data file" $path
}

#---------------- Localization or date time facts -------------------------

function Get-Locale() {
    $locale = $Host.CurrentUICulture.Name
    Write-Status "Running in the [$locale] locale."
}

# (naive) Return $true if the passed date is in the format a) dd/mm/yyyy or b) mm/dd/yyyy, else false
function IsValid-Date($dateString) {
    if ($dateString.length -ne 10 -or $dateString[2] -ne "/" -or $dateString[5] -ne "/") {
        return $false
    }
    return $true
}

# Given a string representing a date, invert the day and month positions
# This only works with the patterns e.g. 31/12/2001 and 12/31/2001
# Return the record with those inversions.
function Convert-Date {
[CmdletBinding()]
    Param (
        [string] $dateString
    )
    if ($dateString.length -eq 0) {
        return "No date found in [Convert-Date]"
    }

    if ($dateString.length -ne 10) {
        return "String [$dateString] passed to [Convert-Date] must have 10 characters"
    }

    if (-not (IsValid-Date($dateString))) {
        return "String [$dateString] passed to [Convert-Date] is not a date"
    }

    return $dateString.Substring(3,2) + "/" + $dateString.Substring(0,2) + "/" + $dateString.Substring(6)
}

# Given an array, convert and return a Delimiter Separated Record, with a default delimiter of [,]
# example:
# Convert-ArrayToCSVRecord -recordSet $testArray -Verbose
# Convert-ArrayToCSVRecord -recordSet $testArray -delimiter ";" -Verbose
function Convert-ArrayToCSVRecord {
 [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        $recordSet,
        $delimiter = ","
    )
    begin {
        [string] $recordToCreate = $null
        [boolean] $first = $true
    }
    process {
        foreach ($record in $recordSet) {
            $delimiterInLoop = if ($first) {$null} else {$delimiter}; $first = $false
            $recordToCreate += "$delimiterInLoop$record"
        }
    }
    end {
        return $recordToCreate
    }
}


#-------------------------------------------------------------------------
# Testing...
<#


#fail...
#Position does not exist
Convert-DatesInFile2 -recordSet $fileToParseInMemory -datePosition 13, 15 -Verbose
#Position1 is not a date
Convert-DatesInFile2 -recordSet $fileToParseInMemory -datePosition 2, 5 -Verbose



# Execute this...
Convert-DatesInFile -path "c:\sandbox\powershell\BasicFile.csv"

#>