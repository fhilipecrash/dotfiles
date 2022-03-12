# Alias
Set-Alias lvim $HOME\.local\bin\lvim.ps1

oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json | Invoke-Expression
