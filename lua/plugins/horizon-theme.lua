return {
  {
    "akinsho/horizon.nvim",
    version = "*",
    config = function()
      vim.opt.background = "dark" -- o "light"
      vim.cmd("colorscheme horizon")
    end,
    opts = {
      plugins = {
        cmp = true,
        indent_blankline = true,
        nvim_tree = true,
        telescope = true,
        which_key = true,
        barbar = true,
        notify = true,
        symbols_outline = true,
        neo_tree = true,
        gitsigns = true,
        crates = true,
        hop = true,
        navic = true,
        quickscope = true,
        flash = true,
      },
    },
  },
}
