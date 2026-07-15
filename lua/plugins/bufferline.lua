return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    opts.options = opts.options or {}
    opts.options.custom_filter = function(buf_number)
      return vim.bo[buf_number].buftype ~= "terminal"
    end
  end,
}
