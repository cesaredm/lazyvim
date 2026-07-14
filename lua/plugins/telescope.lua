-- Añadiendo keys= sigue las reglas explicadas anteriormente.
-- También puede desactivar un mapa de teclas predeterminado configurándolo en false.
-- Para anular un mapa de teclas, simplemente agregue uno con el mismo lhs y uno nuevo rhs.
if true then
  return {}
end

return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        ".next",
        "dist",
        "build",
        ".git",
      },
    },
  },
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    -- change a keymap
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
  },
}
