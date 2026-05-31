$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/io-an/neovim-config.git"
$RepoDir = "$env:LOCALAPPDATA\neovim-config"
$ConfigLink = "$env:LOCALAPPDATA\nvim"

Write-Host "Проверка зависимостей..." -ForegroundColor Cyan

# Проверяем наличие команд
$commands = @("git", "node", "python", "rg", "clang")
$missing = @()
foreach ($cmd in $commands) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        $missing += $cmd
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Ошибка: следующие команды не найдены:" -ForegroundColor Red
    foreach ($m in $missing) { Write-Host "  - $m" -ForegroundColor Red }
    Write-Host "Установите их и повторите запуск." -ForegroundColor Red
    exit 1
}

# Проверяем работоспособность node и python
$nodeOk = $true
try { node --version | Out-Null } catch { $nodeOk = $false }
if (-not $nodeOk) {
    Write-Host "Ошибка: Node.js работает некорректно." -ForegroundColor Red
    exit 1
}

$pythonOk = $true
try { python --version | Out-Null } catch { $pythonOk = $false }
if (-not $pythonOk) {
    Write-Host "Ошибка: Python работает некорректно." -ForegroundColor Red
    exit 1
}

Write-Host "Все необходимые зависимости установлены." -ForegroundColor Green

# Установка Neovim, если отсутствует
if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Write-Host "Установка Neovim через winget..."
    winget install Neovim.Neovim --accept-package-agreements --accept-source-agreements
    if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
        Write-Host "Установите Neovim вручную: https://github.com/neovim/neovim/releases" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Neovim уже установлен: $(nvim --version | Select-Object -First 1)"
}

# Клонирование или обновление репозитория
if (Test-Path "$RepoDir\.git") {
    Write-Host "Обновление конфигурации..."
    git -C $RepoDir pull --ff-only
} else {
    Write-Host "Клонирование конфигурации..."
    git clone $RepoUrl $RepoDir
}

# Настройка симлинка
if (Test-Path $ConfigLink) {
    if ((Get-Item $ConfigLink).LinkType -eq "SymbolicLink") {
        Write-Host "Симлинк уже существует."
    } else {
        Write-Host "Резервная копия: $ConfigLink.bak"
        Remove-Item "$ConfigLink.bak" -Recurse -Force -ErrorAction SilentlyContinue
        Rename-Item $ConfigLink "$ConfigLink.bak"
    }
}

# Создаём Junction, если возможно, иначе копируем
$junctionOk = $true
New-Item -ItemType Junction -Path $ConfigLink -Target $RepoDir -Force -ErrorAction SilentlyContinue | Out-Null
if (-not $?) {
    $junctionOk = $false
}

if ($junctionOk) {
    Write-Host "Junction создан: $ConfigLink -> $RepoDir"
} else {
    Write-Host "Копирование файлов в $ConfigLink..."
    Copy-Item -Path "$RepoDir\*" -Destination $ConfigLink -Recurse -Force
}

# Установка плагинов
Write-Host "Синхронизация плагинов..."
nvim --headless "+Lazy! sync" +qa

Write-Host "Готово! Запустите 'nvim' или 'neovide'." -ForegroundColor Green