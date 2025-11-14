" Redefine command used for K, which is setup in `$VIMRUNTIME/ftplugin/ps1.vim`
command! -buffer -nargs=1 GetHelp silent execute 'botright horizontal terminal ' .. s:pwsh_cmd .. ' -NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command Get-Help -Full "<args>"' .. (executable('less') ? ' | less' : '')

