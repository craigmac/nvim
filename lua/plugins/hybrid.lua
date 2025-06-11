require('hybrid').setup({
  italics = { strings = false, emphasis = false, comments = false, folds = false, },
  overrides = function(highlights, colors)
    highlights['@markup.raw.block'] = { bg = colors.none }
    highlights['@markup.raw'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextError'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextWarn'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextInfo'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextHint'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextOk']   = { bg = colors.none }
  end,
})
require('hybrid').load()


