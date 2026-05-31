-- Настройки графического клиента Neovide.
-- Загружается только при запуске через Neovide (g:neovide == true).

-- Единая переменная для включения/отключения анимаций.
-- Установите её в false, чтобы полностью отключить плавные эффекты.
if vim.g.neovide_animations_enabled == nil then
  vim.g.neovide_animations_enabled = true
end

-- Шрифт зависит от операционной системы.
-- Windows: Consolas, Linux/macOS: Hurmit Nerd Font Mono.
local font_family = 'Hurmit Nerd Font Mono'
if vim.fn.has('win32') == 1 then
  font_family = 'Consolas'
end
vim.g.neovide_font = font_family .. ':h14'
vim.g.neovide_font_size = 14

-- Прозрачность окна (1.0 – без прозрачности)
vim.g.neovide_window_opacity = 1.0

-- Анимации включаются/выключаются одной переменной
if vim.g.neovide_animations_enabled then
  vim.g.neovide_animation_speed = 0.3
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_cursor_trail_size = 0.3
  vim.g.neovide_cursor_vfx_mode = ''   -- без эффектов курсора, можно изменить
else
  vim.g.neovide_animation_speed = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = ''
end