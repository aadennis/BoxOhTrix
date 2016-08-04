<#
    Given a set of files, for each file, if a line does not contain the pattern, then
    write the line to name-copy-plus-suffix of the file, else do not write the line.
#>
$root = "C:\Sandbox"
cd $root
$fileSet = Get-ChildItem -Path .\*.xml -Name
$fileSet

$hexChar = "[A-Fa-f0-9]"

$guidPattern = "\b$hexChar{8}-$hexChar{4}-$hexChar{4}-$hexChar{4}-$hexChar{12}\b"

$fileSet | foreach {
    $fileName = "$root\$_"
    $fileToSave = "$fileName" + ".sansGuid"
    Write-Host "Processing $fileName"
    $reader = New-Object -TypeName System.IO.StreamReader("$fileName")
    $writer = [System.IO.StreamWriter] $fileToSave
    $writer.Write("");

    while (($line = $reader.ReadLine()) -ne $null) {
        if ($line -notMatch $guidPattern) {
            $writer.WriteLine($line)
        }
    }
    $writer.Close()
    $reader.Close();
 }



