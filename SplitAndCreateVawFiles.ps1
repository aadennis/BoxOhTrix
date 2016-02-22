function Get-FileName($extension = "txt") {
    "{0}{1}_{2}.{3}" -f ($outputRootDir, $outputFileNamePrefix, $chunk, $extension)
}

function Write-WavFile() {
    $speech = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $speech.SelectVoice("Microsoft Hazel Desktop")
    $textToSpeak = Get-Content -Path $(Get-FileName) -Encoding UTF8
    $speech.SetOutputToWaveFile($(Get-FileName "wav"))
    $speech.Speak($textToSpeak)
    $speech.Dispose()
    $speech = $null
}

# This expects a $splitMarker in a source file, to denote the string where 1 file is to end and another is to start
# All the output files have the same name, differing only by the incrementing counter $chunk
function Split-File (
    $fileToSplit = 'C:\Temp\PandP.txt',
    $splitMarker = "SPLITHERE",
    $outputFileNamePrefix = "austenx",
    $outputRootDir = "c:\temp\"
    ) {
    Add-Type -AssemblyName System.Speech
    
    $reader = New-Object -TypeName System.IO.StreamReader($fileToSplit)
    $chunk = 1
    $first = $true
    $speech = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $speech.SelectVoice("Microsoft Hazel Desktop")
    while (($line = $reader.ReadLine()) -ne $null) {
        if ($line -match $splitMarker) {
            Write-WavFile
            $chunk++
        } else {
            Add-Content -Path $(Get-FileName "txt") -Value $line -Encoding utf8
        }
    }
    Write-WavFile
    $reader.Close()
    $reader.Dispose()
    $reader = $null
}

#entry point...
Split-File 