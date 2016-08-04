<# 
.Synopsis
     If the passed string contains only allowed characters, return true, 
     else return false.
     The character is Allowed if it is not in the set of disallowed characters in the function
.Example 
    $actualResult = Test-AllCharactersAllowed $TestString
#>
function Test-AllCharactersAllowed {
[CmdletBinding(SupportsShouldProcess)]
Param (
[Parameter(Mandatory)]
    [string] $StringToCheck
)
   $DISALLOWED_CHARACTERS = '[",$% ]'
   return $StringToCheck -notmatch $DISALLOWED_CHARACTERS
}


#Test function - not for production
function Compare-ExpectedAndActualResults($TestString, $ExpectedResult) {
    $actualResult = Test-AllCharactersAllowed $TestString
    if ($ExpectedResult -ne $actualResult) {
        Write-Host "FAIL: String under test:[$TestString];`t Expected:[$ExpectedResult];`t Actual: [$actualResult]" -BackgroundColor Red -ForegroundColor White
        return
    }
    Write-Host "PASS: String under test:[$TestString];`t Expected:[$ExpectedResult];`t Actual: [$actualResult]" -BackgroundColor White -ForegroundColor Black
}

<# Tests...
Compare-ExpectedAndActualResults "thisisok" $true
Compare-ExpectedAndActualResults "thisis notok" $false
Compare-ExpectedAndActualResults "also`$notok" $false
Compare-ExpectedAndActualResults "ThisOneIs-Absolutely!Fine" $true
#>


