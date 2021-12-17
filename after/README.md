Files inside of subfolders here are read last in Vim's 'runtimepath', so
we can put stuff in here to overrule some defaults that load from Vim's
`:echo $VIMRUNTIME` if we can't stop them from loading for instance with a
variable in our `~/.vim/vimrc` or e.g., `~/.vim/ftplugin/python.vim`.

Depending on the script in the VIMRUNTIME directory, sometimes there's an
option to stop if from loading (a guard) that we can set e.g. in our vimrc or
ftplugin/foo.vim for that filetype to stop the default plugin from loading at
all, but it's not guaranteed.

http://vimways.org/2018/from-vimrc-to-vim/
