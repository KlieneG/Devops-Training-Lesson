BeforeAll {
    $functionFile = Join-Path $PSScriptRoot "userchangepass.ps1"

    Write-Host "Loading file: $functionFile"

    if (-not (Test-Path $functionFile)) {
        throw "File not found: $functionFile"
    }

    . $functionFile

    $functionCommand = Get-Command ChangePassword -CommandType Function -ErrorAction SilentlyContinue

    if (-not $functionCommand) {
        throw "ChangePassword function was not loaded from $functionFile"
    }

    Write-Host "ChangePassword function loaded successfully!"
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
