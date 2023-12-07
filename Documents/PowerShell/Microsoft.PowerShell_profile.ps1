# Alias
Set-Alias la ls

function Set-Location {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false,ValueFromPipeline)]
        $string
    )
    Process {
        if (!$string) {
            Microsoft.PowerShell.Management\Set-Location -Path 'C:\Users\fhili'
            return
        }
        Microsoft.PowerShell.Management\Set-Location -Path $string
        $host.ui.RawUI.WindowTitle = "$($Env:UserName)@$(Invoke-Expression -Command 'hostname'):$(pwd)".replace('C:\Users\fhili', '~')
    }
}

function docker {
    wsl -d "Arch" docker @Args
}

function docker-compose {
    wsl -d "Arch" docker-compose @Args
}

# Import Modules
Import-Module Terminal-Icons
#Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Start Starship
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
$host.ui.RawUI.WindowTitle = "$($Env:UserName)@$(Invoke-Expression -Command 'hostname'):$(pwd)".replace('C:\Users\fhili', '~')