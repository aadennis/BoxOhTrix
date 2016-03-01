function Get-FileName($extension = "txt") {
    "{0}{1}_{2}.{3}" -f ($outputRootDir, $outputFileNamePrefix, $currFileCount, $extension)
}

function Write-WavFile($speechChunk) {
    $speech = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $speech.SelectVoice("Microsoft Hazel Desktop")
    $speech.SetOutputToWaveFile($(Get-FileName "wav") )
    $speech.Speak($speechChunk)
    $speech.Dispose()
    $speech = $null
}

function Check-Input (
    $splitMarker,
    $numberOfLinesPerFile
) {
    Write-Host "Validating input..."
    $splitMarker
    $numberOfLinesPerFile
    if (($splitMarker -ne $null) -and ($numberOfLinesPerFile -ne $null)) {
        Write-Host "You cannot specify both a SplitMarker and the required lines per file. Exiting..."
        exit
    }

    
}

function Write-WavFilex() {
     $speech = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
     $speech.SelectVoice("Microsoft Hazel Desktop")
     $textToSpeak = Get-Content -Path $(Get-FileName) -Encoding UTF8
     $speech.SetOutputToWaveFile($(Get-FileName "wav"))
     $speech.Speak($textToSpeak)
     $speech.Dispose()
     $speech = $null
 }

function Check-StringInFile (
    $fileName,
    $stringToFind
) {
    $totalLinesFound = $(Get-Content $fileName) -match $stringToFind
    if ($totalLinesFound -eq 0) {
        return $false
    }
    return $true
}


function Split-File (
    $fileToSplit = 'C:\Temp\pandp.txt',
    $splitMarker = $null,
    $outputFileNamePrefix = "\Judex",
    $outputRootDir = "c:\temp\",
    $numberOfLinesPerFile = 100
) {
    Check-Input $splitMarker $numberOfLinesPerFile
    if (($splitMarker -ne $null) -and ((Check-StringInFile $fileToSplit $splitMarker)) -eq $false) {
        $stuff = "Could not find split marker [{0}] in file [{1}]. Exiting..." -f $splitMarker, $fileToSplit
        Write-Host $stuff 
        exit
    }

    Add-Type -AssemblyName System.Speech
    $reader = New-Object -TypeName System.IO.StreamReader($fileToSplit, [System.Text.Encoding]::UTF8)
    $speech = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $speech.SelectVoice("Microsoft Hazel Desktop")

    $currFileCount = 1
    $currLineCount = 0

    $currChunk = @()
    $currChunk += "Start of book - section {0};" -f ($currFileCount)
    
    while (($line = $reader.ReadLine()) -ne $null) {

        # For now, just separate the 2 approaches into different code blocks...
        if ($splitMarker -eq $null) {
            if ($currLineCount++ -ge $numberOfLinesPerFile) {
                $currChunk += "End of section {0}" -f ($currFileCount)
                Write-WavFile $currChunk
                $currLineCount = 0
                $currFileCount++
                $currChunk = @()
                $currChunk += "Start of Section {0};" -f ($currFileCount)
                "{0}:{1}" -f ($(Get-Date), $($currChunk))
            } else {
                $currChunk += $line
            }
        } else { # the user is specifying the file break...
            if ($line -match $splitMarker) {
               Write-WavFilex
               $currFileCount++
            } else {
                Add-Content -Path $(Get-FileName "txt") -Value $line -Encoding UTF8
            }
        }

    }
    Write-WavFile $currChunk
    $reader.Close()
    $reader.Dispose()
    $reader = $null
}

$currDir = "c:\sandbox\PowerShell"
#entry point...
#Split-File -splitMarker "SPLITHERE" -fileToSplit $currDir\PAndP.txt -outputRootDir $currDir

#Split-File -fileToSplit C:\sandbox\PowerShell\SmallTestFile.txt -outputRootDir $currDir -numberOfLinesPerFile 5
Split-File -fileToSplit C:\sandbox\PowerShell\JudeTheObscure.txt -outputRootDir $currDir -numberOfLinesPerFile 800
