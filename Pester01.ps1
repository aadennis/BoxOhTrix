function Add-Footer($path, $footer) {
    Add-Content $path -Value $footer
}
function Add-Number($a, $b) {
    $a + $b
}
function Multiply-Number($a, $b) {
    $a * $b
}

Describe "Add-Footer" {
    $testPath = Join-Path $TestDrive "test.txt"
    Set-Content $testPath -value "my test text."
    Add-Footer $testPath "-Footer"
    $result = Get-Content $testPath

    It "adds a footer" {
        (-join $result) | Should Be "my test text.-Footer"
    }

    It "certainly should not be this" {
        (-join $result) | Should Not Be "my nonsense test text.-Footer"
    }
}

Describe "Basic-Math" {
    $a = 2
    $b = 7
    It "adds numbers correctly" {
        Add-Number $a $b | Should Be 9
    }

    It "multiplies numbers correctly" {
        Multiply-Number $a $b | Should Be 13
    }
}

