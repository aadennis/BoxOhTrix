$m = @'
<# 
.Synopsis
     Basic function template - replace with your own Things 
.Example 
    Do-Things -ThingsPrefix "pre_"
.Example 
    Do-Things -ThingsPrefix "pre_" -Verbose
.Example 
    Do-Things -ThingsPrefix "before_" -LoopCount 3 -Verbose
#>
function Do-Things {
[CmdletBinding(SupportsShouldProcess)]
Param (
[Parameter(Mandatory)]
    $ThingsPrefix,
[Parameter()]
    [int] $LoopCount = 22
)
    Begin {
        Write-Verbose "I am in the Begin block with [$ThingsPrefix]"
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
'@

New-ISESnippet -Text $m -Title "a Basic function template" -Description "Basic template to be enhanced." -Author "This Company" -Force


