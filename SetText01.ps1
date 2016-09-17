$searchString = 'bank' 
$replaceString = 'tornado'
$rootDir = 'C:\temp4'

cd $rootDir
pwd
"*** Searching for files in [$pwd] containing [$searchString] ***"

#gci -Recurse | Select-Object Extension -Unique
$fileList = gci -Recurse -Path .\* -Include *.txt, *.ext

$fileList | % {
    $file = $_.FullName
    $content = Get-Content $file
    if ($content -like "*$searchString*") {
        "[$file]: found search string [$searchString], replacing with [$replaceString]"
        (Get-Content $file).Replace($searchString, $replaceString) | Set-Content $file
    }
}
