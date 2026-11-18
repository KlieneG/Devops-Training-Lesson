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

#Run as Admin
RunAsAdministrator

function ChangePassword {
    try {
        $changePassword = Read-Host -Prompt "Please input a passowrd
    Make sure to have 12 minimum character with small and big letter,
    numbers and special characters" -AsSecureString
        Set-LocalUser -Name $env:USERNAME -Password $changePassword
        Write-Output "Password Updated! After successuly run the command it will permantly delete the file"
        Start-Sleep -Seconds 4
        Remove-Item $script:MyInvocation.MyCommand.Path -Force
    }
    catch {
        Write-Output "You input a wrong password context"
    }    

}

//Call the Function ChangePassword
ChangePassword


