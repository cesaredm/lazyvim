-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Reasignar la acción de ventanas a <leader>W (mayúscula)
-- vim.keymap.set("n", "<leader>W", "<C-w>", { desc = "Gestión de ventanas" })
-- Guardar
-- vim.keymap.set("n", "<leader>w",":w<CR>", {desc:"Guardar archivo"})

-- Usar Tab para ir al siguiente tab/buffer
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Ir al siguiente buffer" })

-- Usar Shift+Tab para ir al anterior
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Ir al buffer anterior" })

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
  local bufnr = vim.fn.bufnr("%")
  if vim.bo.buftype == "terminal" then
    vim.cmd("hide") -- oculta el buffer, proceso sigue vivo
  else
    vim.cmd("split | terminal") -- abre nueva si no hay
  end
end, { desc = "Toggle terminal actual" })

-- Toggle de todas las terminales (ocultar todas sin cerrar procesos)
vim.keymap.set("n", "<leader>ta", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("hide")
      end)
    end
  end
end, { desc = "Ocultar todas las terminales" })
