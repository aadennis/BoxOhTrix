$myHashTable = @{
    "Entry 1" = "President Clinton";
    "Entry 2" = "Max Wall";
    "Entry 3" = "Korky the Cat";
}

$myHashTable

foreach ($entry in $myHashTable) {
    "In the foreach: $entry"
}

foreach ($key in $myHashTable.Keys) {
    "In the foreach: $key"
    "The value: [$($myHashTable[$key])]"
}


