require('hybrid').setup({
  italics = {
    strings = false,
    emphasis = false,
    comments = false,
    folds = false
  },
  overrides = function(highlights, colors)
    -- colors listed here:
    -- https://github.com/HoNamDuong/hybrid.nvim/blob/master/lua/hybrid/colors.lua#L45
    highlights['@markup.raw.block']          = { bg = colors.none }
    highlights['@markup.raw']                = { bg = colors.none }

    highlights['Comment']                    = { fg = colors.fg_soft, italic = false }
    highlights['CurSearch']                  = { link = 'IncSearch' }

    highlights['DiagnosticVirtualTextError'] = { bg = colors.none }
    highlights['DiagnosticVirtualTextWarn']  = { bg = colors.none }
    highlights['DiagnosticVirtualTextInfo']  = { bg = colors.none }
    highlights['DiagnosticVirtualTextHint']  = { bg = colors.none }
    highlights['DiagnosticVirtualTextOk']    = { bg = colors.none }

    -- fix border bleed by removing border and float bg coloring
    highlights['FloatBorder']                = { bg = colors.none }
    highlights['FloatTitle']                 = { bg = colors.none }
    highlights['FloatFooter']                = { bg = colors.none }

    -- make marked files obvious
    highlights['netrwMarkFile']              = { reverse = true }

    -- remove backgrounds to blend with terminal colorscheme better
    highlights['Normal']                     = { bg = colors.none, fg = colors.none }
    highlights['NormalNC']                   = { bg = colors.none, fg = colors.none }
    highlights['NormalFloat']                = { bg = colors.none }

    -- do like default colorscheme does
    highlights['StatusLine']                 = { fg = colors.bg, bg = colors.fg }
    highlights['StatusLineNC']               = { fg = colors.bg, bg = colors.fg_soft }

    highlights['MsgSeparator']               = { fg = colors.fg, bg = colors.none }
    highlights['TabLine']                    = { link = 'StatusLineNC' }
    highlights['TabLineFill']                = { link = 'StatusLineNC' }
    highlights['TabLineSel']                 = { link = 'StatusLine' }

    highlights['WinBar']                     = { bg = colors.bg, fg = colors.blue }
    highlights['WinBarNC']                   = { bg = colors.bg, fg = colors.fg }
    highlights['WinSeparator']               = { link = 'NonText' }

    -- for use in 'stl', use `%<N>*` to start and `%*` to reset
    highlights['User1']                      = { bg = colors.red, fg = colors.bg }
    highlights['User2']                      = { bg = colors.green, fg = colors.bg }
    highlights['User3']                      = { bg = colors.yellow, fg = colors.bg }
    highlights['User4']                      = { bg = colors.blue, fg = colors.bg }
    highlights['User5']                      = { bg = colors.magenta, fg = colors.bg }
    highlights['User6']                      = { bg = colors.cyan, fg = colors.bg }
    highlights['User7']                      = { bg = colors.fg, fg = colors.bg }
    highlights['User8']                      = { bg = colors.bg_soft, fg = colors.bg }
    highlights['User9']                      = { bg = colors.bg_hard, fg = colors.fg_hard }
  end,
})
require('hybrid').load()
