if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

" on ft change undo these local settings to global defaults
let b:undo_ftplugin = 'setlocal complete< spell< spelllang< noexpandtab< thesaurus< textwidth<'

setlocal complete+=k/usr/share/dict/words
setlocal spell spelllang=en_ca
setlocal noexpandtab
" Download this yourself, it's 26 megs so not commiting to git
" $ wget -O ~/.vim/mobythesaurus.txt https://raw.githubusercontent.com/words/moby/master/words.txt
setlocal thesaurus=~/.vim/mobythesaurus.txt
setlocal textwidth=100
