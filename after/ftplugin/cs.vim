" C# ftplugin for developing on Windows
"
" use dotnet executable to run .cs files
setlocal makeprg=dotnet
" Turn off shellpiping to tmp error file, so we just see results
setlocal shellpipe=""
" F5 to do 'dotnet run'
noremap <buffer> <F5> <Esc>:<C-u>make run<CR>
" Globally is set to :silent! make, but we aren't using Makefiles
noremap <buffer> <F6> <Esc>

