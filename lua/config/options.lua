-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Configuraciones de vim usando la global vim, este archivo se carga al iniciar lazyvim

--  Configurar shell por defecto en Windows
vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

-- NEOVIDE
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h11" -- fuente
  vim.g.neovide_scale_factor = 0.9
  -- transparencia y blur
  vim.g.neovide_opacity = 0.8 -- transparencia 0.9 poca transparencia 0.8 mas transparencia, y asi sucecivamente
  vim.g.neovide_window_blurred = true
  -- Pantalla completa
  vim.g.neovide_fullscreen = true

  -- Animaciones del cursor
  vim.g.neovide_cursor_vfx_mode = "railgun" -- opciones: railgun, torpedo, pixiedust, ripple, wireframe
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_density = 12.0
  vim.g.neovide_cursor_vfx_particle_speed = 10.0
  vim.g.neovide_cursor_vfx_particle_phase = 1.5
  vim.g.neovide_cursor_vfx_particle_curl = 1.0

  -- Animación de scroll
  vim.g.neovide_scroll_animation_length = 0.3
end
