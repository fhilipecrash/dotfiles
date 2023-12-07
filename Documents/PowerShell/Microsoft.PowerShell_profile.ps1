# Alias
Set-Alias la ls

function cd {
    Set-Location -Path @Args
    $host.ui.RawUI.WindowTitle = "$($Env:UserName)@$(Invoke-Expression -Command 'hostname'):$(pwd)"
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
#$host.ui.RawUI.WindowTitle = "$($Env:UserName)@$(Invoke-Expression -Command 'hostname'):$(pwd)"