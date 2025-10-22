-- text object: `g?o|O`
-- variable:    `g?v|V`
-- below|above: `g?p|P`
-- surround:    `g?sp`, `g?so`
return {
  'andrewferrier/debugprint',
  enabled = false,
  cond = (not vim.g.vscode) and (not vim.g.firenvim),
  opts = {},
}
