<#
.Synopsis
   Given a length, return a random string based on an internal set of characters
.Example
   Get-RandomString
   Get-RandomString 5
#>
function Get-RandomString {
    [CmdletBinding()]
    Param([int] $Length=1)
    Process {
        $randomChars = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
        $result = $null
        for ($x = 0; $x -lt $Length; $x++) {
            $result += $randomChars | Get-Random
        }
        $result
    }

    
}

<#
.Synopsis
   Given the required length before and after the @ of an email address, return a random email address with a .com domain.
   $Count gives the number of emails to be generated
.Example
   Get-RandomEmail 10 5 => qg9jb3qr1l@ke788.com

   Get-RandomEmail 10 2 2 => 9tcx6dayj3@9i.com, lm0k9aa4vd@4r.com

   Get-RandomEmail => 9ryh8@zturt.com
#>
function Get-RandomEmail {
    [CmdletBinding()]
    Param(
        [int] $BeforeAtLength = 5, 
        [int] $AfterAtLength = 5, 
        [int] $Count = 1 

    )
    Process {
        $emails = @()
        for ($x = 0; $x -lt $Count; $x++) {
            $beforePart = Get-RandomString $BeforeAtLength
            $afterPart = Get-RandomString $AfterAtLength
            $emails += $beforePart + "@" + $afterPart + ".com"
        }
        return $emails
    }
}

<#
.Synopsis
   Given the required length before the . of a web url, return a random url with a .com domain.
   On even calls, make the scheme https, else http.
   $Count gives the number of urls to be generated
.Example
   Get-RandomUrl => http://www.cyz9brumxm.com
   Get-RandomUrl 3 3 => http://www.hh5.com https://www.d0x.com http://www.zu8.com
#>
function Get-RandomUrl {
    [CmdletBinding()]
    Param(
        [int] $Length = 10, 
        [int] $Count = 1 
    )
    Process {
        $urls = @()
        for ($x = 0; $x -lt $Count; $x++) {
            $httpsInd = "s"
            if ($x%2 -eq 0) {
                $httpsInd = ""
            }

            $urlPart = Get-RandomString $Length
            $urls += "http" + $httpsInd + "://www." + $urlPart + ".com"
        }
        return $urls
    }
}