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
