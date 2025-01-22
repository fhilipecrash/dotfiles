Install-Module PSReadLine -AllowPrerelease -Force
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name z -Force

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Scoop não está instalado. Instale o Scoop antes de continuar." -ForegroundColor Red
    exit 1
}

scoop install starship
