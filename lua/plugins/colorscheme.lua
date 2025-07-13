require('hybrid').setup({
  italics = { strings = false, emphasis = false, comments = false, folds = false },
  overrides = function(highlights, colors)
    -- colors listed here:
    -- https://github.com/HoNamDuong/hybrid.nvim/blob/master/lua/hybrid/colors.lua#L45
    highlights['@markup.raw.block'] = { bg = colors.none }
    highlights['@markup.raw'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextError'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextWarn'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextInfo'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextHint'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextOk'] = { bg = colors.none }
    -- fix border bleed by removing border and float bg coloring
    highlights['FloatBorder'] = { bg = colors.none }
    highlights['FloatTitle'] = { bg = colors.none }
    highlights['FloatFooter'] = { bg = colors.none }
    highlights['NormalFloat'] = { bg = colors.none }
    highlights['CurSearch'] = { link = 'IncSearch' }
    highlights['netrwMarkFile'] = { reverse = true }

    highlights['StatusLine'] = { fg = colors.bg, bg = colors.fg }
    highlights['StatusLineNC'] = { fg = colors.bg, bg = colors.fg_soft }
  end,
})
require('hybrid').load()
