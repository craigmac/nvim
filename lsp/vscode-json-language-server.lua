--- https://github.com/hrsh7th/vscode-langservers-extracted
--- sudo npm i -g vscode-langservers-extracted
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
}
