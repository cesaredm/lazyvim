-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Reasignar la acción de ventanas a <leader>W (mayúscula)
-- vim.keymap.set("n", "<leader>W", "<C-w>", { desc = "Gestión de ventanas" })
-- Guardar
-- vim.keymap.set("n", "<leader>w",":w<CR>", {desc:"Guardar archivo"})

-- Función para navegar buffers saltando terminales
local function buffer_nav(direction)
  local bufs = vim.api.nvim_list_bufs()
  local current = vim.api.nvim_get_current_buf()
  local step = direction == "next" and 1 or -1
  local start = 0
  for i, buf in ipairs(bufs) do
    if buf == current then
      start = i
      break
    end
  end
  for i = 1, #bufs do
    local idx = ((start - 1 + i * step) % #bufs) + 1
    local buf = bufs[idx]
    if vim.bo[buf].buftype ~= "terminal" and vim.fn.bufloaded(buf) == 1 and vim.bo[buf].buflisted then
      vim.api.nvim_set_current_buf(buf)
      return
    end
  end
end

-- Usar Tab para ir al siguiente buffer (saltando terminales)
vim.keymap.set("n", "<Tab>", function() buffer_nav("next") end, { desc = "Ir al siguiente buffer" })

-- Usar Shift+Tab para ir al anterior (saltando terminales)
vim.keymap.set("n", "<S-Tab>", function() buffer_nav("prev") end, { desc = "Ir al buffer anterior" })

-- Usar Alt+j / Alt+k para mover 10 líneas
vim.keymap.set("n", "<A-k>", "10k", { desc = "Mover 10 líneas arriba" })
vim.keymap.set("n", "<A-j>", "10j", { desc = "Mover 10 líneas abajo" })
-- Opcional: también en modo visual
vim.keymap.set("v", "<A-k>", "10k", { desc = "Mover seleccion 10 líneas arriba" })
vim.keymap.set("v", "<A-j>", "10j", { desc = "Mover seleccion 10 líneas abajo" })

-- Abrir terminales en splits
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Terminal vertical" })
vim.keymap.set("n", "<leader>th", ":split | terminal<CR>", { desc = "Terminal horizontal" })

-- Dentro de la terminal: ESC → modo normal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Salir a modo normal desde terminal" })

-- Volver a modo insert dentro de la terminal (ya existe con 'i', pero puedes reforzarlo)
vim.keymap.set("n", "i", "i", { desc = "Entrar a modo insert en terminal" })

-- Toggle de la terminal actual (cuando estás en modo normal)
--vim.keymap.set("n", "<leader>tt", ":bdelete!<CR>", { desc = "Cerrar terminal actual" })

-- Toggle de la terminal actual (ocultar/mostrar sin matar proceso)
vim.keymap.set("n", "<leader>tt", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("hide")
  else
    local hidden_terminals = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].buftype == "terminal" and vim.fn.bufloaded(buf) == 1 then
        if #vim.fn.win_findbuf(buf) == 0 then
          table.insert(hidden_terminals, buf)
        end
      end
    end
    if #hidden_terminals > 0 then
      vim.cmd("split")
      vim.api.nvim_win_set_buf(0, hidden_terminals[#hidden_terminals])
    else
      vim.cmd("split | terminal")
    end
  end
end, { desc = "Toggle terminal actual" })

-- Toggle de todas las terminales (ocultar/mostrar todas sin cerrar procesos)
vim.keymap.set("n", "<leader>ta", function()
  local visible_terminals = {}
  local hidden_terminals = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.fn.bufloaded(buf) == 1 then
      local wins = vim.fn.win_findbuf(buf)
      if #wins > 0 then
        for _, win in ipairs(wins) do
          table.insert(visible_terminals, win)
        end
      else
        table.insert(hidden_terminals, buf)
      end
    end
  end

  if #visible_terminals > 0 then
    for _, win in ipairs(visible_terminals) do
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end
  elseif #hidden_terminals > 0 then
    for i, buf in ipairs(hidden_terminals) do
      if i == 1 then
        vim.cmd("split")
      else
        vim.cmd("vsplit")
      end
      vim.api.nvim_win_set_buf(0, buf)
    end
  else
    vim.cmd("split | terminal")
  end
end, { desc = "Toggle todas las terminales" })
