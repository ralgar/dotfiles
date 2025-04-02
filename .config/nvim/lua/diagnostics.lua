vim.diagnostic.config({
  virtual_text = { current_line = true, severity = { max = vim.diagnostic.severity.WARN }, },
  virtual_lines = { current_line = true, severity = { min = vim.diagnostic.severity.ERROR, }, },
  severity_sort = true,
})
