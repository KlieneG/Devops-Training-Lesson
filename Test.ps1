
BeforeAll {
    . "$PSScriptRoot/PasswordFunctions.ps1"
}

Describe "ChangePassword Function Tests" {

    BeforeEach {
        Mock Read-Host {
            ConvertTo-SecureString "TestPassword123!" -AsPlainText -Force
        }

        Mock Set-LocalUser {}
        Mock Start-Sleep {}
        Mock Remove-Item {}
    }

    It "Should call Set-LocalUser once" {
        ChangePassword

        Should -Invoke Set-LocalUser -Times 1 -Exactly
    }

    It "Should use the current username" {
        ChangePassword

        Should -Invoke Set-LocalUser -Times 1 -Exactly `
            -ParameterFilter {
                $Name -eq $env:USERNAME
            }
    }

    It "Should delete the script after successful password update" {
        ChangePassword

        Should -Invoke Remove-Item -Times 1 -Exactly
    }

    It "Should not delete the script when password update fails" {
        Mock Set-LocalUser {
            throw "Simulated password update failure"
        }

        ChangePassword

        Should -Invoke Remove-Item -Times 0 -Exactly
    }
}
