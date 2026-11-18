BeforeAll {
    . $PSScriptRoot/userchangepass.ps1
}

Describe 'ChangePassword' {
    It 'This will check the command for Read-Host' {
        Mock Read-Host { return "Yes"}

        ChangePassword

        Should -Invoke Read-Host -Times 1 -Exactly
    }
}