$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/io-an/neovim-config.git"
$RepoDir = "$env:LOCALAPPDATA\neovim-config"
$ConfigLink = "$env:LOCALAPPDATA\nvim"

Write-Host "Проверка зависимостей..." -ForegroundColor Cyan

function Test-Command($cmd) {
    try {
        if (Get-Command $cmd -ErrorAction Stop) { return $true }
    } catch { return $false }
}

$requiredCommands = @("git", "node", "python", "rg", "cc")
$missing = @()
foreach ($cmd in $requiredCommands) {
    if (-not (Test-Command $cmd)) { $missing += $cmd }
}

if ($missing.Count -gt 0) {
    Write-Host "Ошибка: следующие команды не найдены:" -ForegroundColor Red
    foreach ($m in $missing) { Write-Host "  - $m" -ForegroundColor Red }
    Write-Host "Установите их и повторите запуск." -ForegroundColor Red
    exit 1
}

# Проверяем работоспособность node и python
try { node --version | Out-Null } catch {
    Write-Host "Ошибка: Node.js работает некорректно." -ForegroundColor Red
    exit 1
}
try { python --version | Out-Null } catch {
    Write-Host "Ошибка: Python работает некорректно." -ForegroundColor Red
    exit 1
}

Write-Host "Все необходимые зависимости установлены." -ForegroundColor Green

function Install-Neovim {
    if (Get-Command nvim -ErrorAction SilentlyContinue) {
        Write-Host "Neovim найден: $(nvim --version | Select-Object -First 1)"
    } else {
        Write-Host "Установка Neovim через winget..."
        winget install Neovim.Neovim --accept-package-agreements --accept-source-agreements
        if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
            Write-Host "Установите Neovim вручную: https://github.com/neovim/neovim/releases" -ForegroundColor Red
            exit 1
        }
    }
}

function Setup-Repo {
    if (Test-Path "$RepoDir\.git") {
        Write-Host "Обновление конфигурации..."
        git -C $RepoDir pull --ff-only
    } else {
        Write-Host "Клонирование конфигурации..."
        git clone $RepoUrl $RepoDir
    }
}

function Link-Config {
    if (Test-Path $ConfigLink) {
        if ((Get-Item $ConfigLink).LinkType -eq "SymbolicLink") {
            Write-Host "Симлинк уже существует."
            return
        }
        Write-Host "Резервная копия: $ConfigLink.bak"
        Remove-Item "$ConfigLink.bak" -Recurse -Force -ErrorAction SilentlyContinue
        Rename-Item $ConfigLink "$ConfigLink.bak"
    }
    try {
        New-Item -ItemType Junction -Path $ConfigLink -Target $RepoDir -Force | Out-Null
        Write-Host "Junction создан: $ConfigLink -> $RepoDir"
    } catch {
        Write-Host "Копирование файлов в $ConfigLink..."
        Copy-Item -Path "$RepoDir\*" -Destination $ConfigLink -Recurse -Force
    }
}

function Install-Plugins {
    Write-Host "Синхронизация плагинов..."
    nvim --headless "+Lazy! sync" +qa
}

Install-Neovim
Setup-Repo
Link-Config
Install-Plugins
Write-Host "Готово! Запустите 'nvim' или 'neovide'." -ForegroundColor Green
