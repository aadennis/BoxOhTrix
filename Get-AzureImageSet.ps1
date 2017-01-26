Set-StrictMode -Version latest

<#
.Synopsis
   Based on a wild card occurring in the image name to start, get the set of Azure images available.
   The set is returned in a nice format, which can be further restricted using PowerShell's GUI filtering
   abilities.
   As a bonus, the ImageName of the first found image is saved to the clipboard
   The image names change from month to month, so in an automated run, do not assume the previously 
   existing image will still be there.
   An example of the value returned in the clipboard (Windows Server 2012 R2 / Sql Server 2014 SP1 at the time of writing)
    fb83b3509582419d99629ce476bcb5c8__SqlServer-2014-Sp1-12.0.4449.9-Standard-ENU-WS2012R2-CY16-SU03
    Dependencies: [Add-AzureAccount]
   See https://azure.microsoft.com/en-gb/documentation/articles/virtual-machines-command-line-tools
.Example
   Get-AzureVMImageNameByLabel
   Get-AzureVMImageNameByLabel -imageWildCard 2014
   Get-AzureVMImageNameByLabel -imageWildCard 2014 -maxResults 3
   Get-AzureVMImageNameByLabel -imageWildCard "2014 SP1 Standard" -maxResults 30
#>

function Get-AzureVMImageNameByLabel {
[CmdletBinding()]
    Param (
        [string] $imageWildCard = $null,
        [int] $maxResults = $null
    )
    if ($imageWildCard -eq $null) {
        $imageSet = Get-AzureVMImage 
        $imageSet |  Out-GridView

    } else {
        $imageSet = Get-AzureVMImage | where {$_.label -match $imageWildCard } | select label, ImageName, ImageFamily, OS, Description, Location 
        if ($maxResults -eq $null) {
            $maxResults = 1000
        }
        $imageSet | select -First $maxResults | Out-GridView
        $imageSet | select -First 1 ImageName | clip.exe
    }
}

Get-AzureVMImageNameByLabel -imageWildCard "2016" -maxResults 30
