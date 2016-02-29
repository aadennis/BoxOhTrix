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

function Split-File (
    $fileToSplit = 'C:\Temp\pandp.txt',
    $splitMarker = $null,
    $outputFileNamePrefix = "\Judex",
    $outputRootDir = "c:\temp\",
    $numberOfLinesPerFile = 4
) {
    Add-Type -AssemblyName System.Speech
    $reader = New-Object -TypeName System.IO.StreamReader($fileToSplit, [System.Text.Encoding]::UTF8)
    $chunk = $numberOfLinesPerFile
    $currFileCount = 1
    $currLineCount = 0
    $speech = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $speech.SelectVoice("Microsoft Hazel Desktop")
    $currChunk = @()
    $currChunk += "Start of book - section {0};" -f ($currFileCount)
    
    while (($line = $reader.ReadLine()) -ne $null) {
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
    }
    Write-WavFile $currChunk
    $reader.Close()
    $reader.Dispose()
    $reader = $null
}

$currDir = "c:\sandbox\PowerShell"
#entry point...
Split-File -fileToSplit $currDir\JudeTheObscure.txt -outputRootDir $currDir -numberOfLinesPerFile 800

