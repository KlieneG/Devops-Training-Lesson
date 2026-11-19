Function RunAsAdministrator()
{
  #Get current user context
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  
  #Check user is running the script is member of Administrator Group
  if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
  {
       Write-host "Script is running with Administrator privileges!"
  }
  else
    {
       #Create a new Elevated process to Start PowerShell
       $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
 
       # Specify the current script path and name as a parameter
       $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
 
       #Set the Process to elevated
       $ElevatedProcess.Verb = "runas"
 
       #Start the new elevated process
       [System.Diagnostics.Process]::Start($ElevatedProcess)
 
       #Exit from the current, unelevated, process
       Exit
 
    }
}



function ChangePassword {
    try {
        $changePassword = Read-Host -Prompt "Enter new password" -AsSecureString

        Set-LocalUser -Name $env:USERNAME `
            -Password $changePassword `
            -ErrorAction Stop

        Write-Output "Password Updated!"

        Start-Sleep -Seconds 4

        Remove-Item $PSCommandPath -Force
    }
    catch {
        Write-Output "Password update failed: $($_.Exception.Message)"
    }
}



