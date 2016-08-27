#Tests for the script file UtilitiesTest.ps1

Set-StrictMode -Version latest

$rootDir = "E:\Sandbox\PowerShell\BoxOhTrix"
Set-Location $rootDir
. .\Utilities.ps1

Describe "Convert-ArrayToCSVRecord" {
    It "concats the content of 2 arrays into a variable containing 2 record strings" {

        #arrange 
        $testArray = @()
        $testArray += "The first field"
        $testArray += 22
        $testArray += "01/01/2020"
        $testArray += "10109.222"
        $cumulativeRecordSet = @()
        $expectedRecord0 = "The first field,22,01/01/2020,10109.222"
        $expectedRecord1 = "The first field;22;01/01/2020;10109.222"
        
        #act
        $recordWithComma = Convert-ArrayToCSVRecord -recordSet $testArray -Verbose
        $cumulativeRecordSet += "$recordWithComma"
        $recordWithSemiColon = Convert-ArrayToCSVRecord -recordSet $testArray -delimiter ";" -Verbose
        $cumulativeRecordSet += "$recordWithSemiColon"

        #assert
        $cumulativeRecordSet.Count | should be 2
        $cumulativeRecordSet[0] | should be $expectedRecord0
        $cumulativeRecordSet[1] | should be $expectedRecord1
        
    }
}

Describe "Convert-Date" {
    It "returns a string describing the error if the date is not valid" {
    #arrange 
        $badDate1 = "22/12/2015x"
        $badDate2 = "22x12/2015"
        $badDate3 = "22/12x2015"
        
        #act
        $ret1 = Convert-Date $badDate1 
        $ret2 = Convert-Date $badDate2
        $ret3 = Convert-Date $badDate3

        #assert
        $ret1 | should be "String [22/12/2015x] passed to [Convert-Date] is not a date" 
        $ret2 | should be "String [22x12/2015] passed to [Convert-Date] is not a date" 
        $ret3 | should be "String [22/12x2015] passed to [Convert-Date] is not a date" 
    }

    It "returns the converted date" {
    #arrange 
        $dateGBFormat = "22/12/2015"
        $dateUSFormat = "12/22/2015"
        
        #act
        $ret = Convert-Date $dateGBFormat 

        #assert
        $ret | should be $dateUSFormat
    }

}