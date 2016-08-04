<# 
.Synopsis
     Basic function template - replace with your own stuff 
.Example 
    Do-Stuff -StuffPrefix "pre_"
    Do-Stuff -StuffPrefix "pre_" -Verbose
    Do-Stuff -StuffPrefix "before_" -LoopCount 3 -Verbose

    #https://msdn.microsoft.com/en-us/powershell/scripting/core-powershell/ise/introducing-the-windows-powershell-ise
#>
function Do-Stuff {
[CmdletBinding(SupportsShouldProcess)]
Param (
[Parameter(Mandatory)]
    $StuffPrefix,
[Parameter()]
    [int] $LoopCount = 22
)
    Begin {
        Write-Verbose "I am in the Begin block with [$StuffPrefix]"
    }
    Process {
        1..$LoopCount | foreach {
            Write-Verbose "I am in the Process block [$_]"
        }
    }
    End {
        Write-Verbose "I am in the End block"
    }
}

