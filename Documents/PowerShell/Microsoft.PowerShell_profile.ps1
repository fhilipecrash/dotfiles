# Alias
Set-Alias lvim $HOME\.local\bin\lvim.ps1
Set-Alias ll ls

# Import Modules
Import-Module Terminal-Icons

# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

oh-my-posh --init --shell pwsh --config $HOME\Documents\PowerShell\my_powerlevel10k.omp.json | Invoke-Expression
