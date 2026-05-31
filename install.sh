#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/io-an/neovim-config.git"
REPO_DIR="$HOME/.local/share/neovim-config"
CONFIG_LINK="$HOME/.config/nvim"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Проверка наличия команды
check_command() {
  if ! command -v "$1" &>/dev/null; then
    echo -e "${RED}Ошибка: команда '$1' не найдена. Установите её и повторите запуск.${NC}"
    exit 1
  fi
}

echo "Проверка зависимостей..."
check_command git
check_command node
check_command python3
check_command rg       # ripgrep
check_command cc       # компилятор C (для tree-sitter)

# Дополнительно убеждаемся, что node и python3 работают
if ! node --version &>/dev/null; then
  echo -e "${RED}Ошибка: Node.js работает некорректно.${NC}"
  exit 1
fi
if ! python3 --version &>/dev/null; then
  echo -e "${RED}Ошибка: Python 3 работает некорректно.${NC}"
  exit 1
fi

echo -e "${GREEN}Все необходимые зависимости установлены.${NC}"

install_nvim() {
  if command -v nvim &>/dev/null; then
    echo "Neovim уже установлен: $(nvim --version | head -1)"
    return
  fi
  echo "Установка Neovim..."
  if [[ "$(uname)" == "Darwin" ]]; then
    command -v brew &>/dev/null || { echo -e "${RED}Установите Homebrew: https://brew.sh${NC}"; exit 1; }
    brew install neovim
  elif [[ -f /etc/debian_version ]]; then
    sudo apt update && sudo apt install -y neovim
  elif [[ -f /etc/arch-release ]]; then
    sudo pacman -S --noconfirm neovim
  elif [[ -f /etc/fedora-release ]]; then
    sudo dnf install -y neovim
  else
    echo -e "${RED}Неизвестный дистрибутив. Установите Neovim вручную: https://github.com/neovim/neovim/wiki/Installing-Neovim${NC}"
    exit 1
  fi
}

setup_repo() {
  if [[ -d "$REPO_DIR/.git" ]]; then
    echo "Обновление конфигурации..."
    git -C "$REPO_DIR" pull --ff-only
  else
    echo "Клонирование конфигурации..."
    git clone "$REPO_URL" "$REPO_DIR"
  fi
}

link_config() {
  if [[ -L "$CONFIG_LINK" ]]; then
    echo "Симлинк $CONFIG_LINK уже существует."
  elif [[ -e "$CONFIG_LINK" ]]; then
    echo "Создаётся резервная копия $CONFIG_LINK.bak"
    mv "$CONFIG_LINK" "$CONFIG_LINK.bak"
  fi
  ln -sfn "$REPO_DIR" "$CONFIG_LINK"
  echo "Симлинк: $CONFIG_LINK → $REPO_DIR"
}

install_plugins() {
  echo "Установка/обновление плагинов..."
  nvim --headless "+Lazy! sync" +qa
}

install_nvim
setup_repo
link_config
install_plugins
echo -e "${GREEN}Готово! Запустите 'nvim' или 'neovide'.${NC}"
