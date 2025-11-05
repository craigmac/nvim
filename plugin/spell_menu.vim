" Spell suggestions in a popup menu.
" yanked from $VIMRUNTIME/menu.vim

function! s:SpellPopup() abort
  if exists("s:changeitem") && s:changeitem != ''
    call <SID>SpellDel()
  endif

  " Return quickly if spell checking is not enabled.
  if !&spell || &spelllang == '' | return | endif

  let curcol = col('.')
  let [w, a] = spellbadword()

  " don't use word after the cursor
  if col('.') > curcol
    let w = ''
  endif

  " we have a bad word on this line, w is empty string when is none
  if w != ''
    " for caps error suggest a single string list, the bad word with capitalization fixed
    if a == 'caps'
      let s:suglist = [substitute(w, '.*', '\u&', '')]
    else
      let s:suglist = spellsuggest(w, 10)
    endif

    " we have more than one suggestion in the list
    if len(s:suglist) > 0
      if !exists("g:menutrans_spell_change_ARG_to")
        let g:menutrans_spell_change_ARG_to = 'Change\ "%s"\ to'
      endif

      let s:changeitem = printf(g:menutrans_spell_change_ARG_to, escape(w, ' .'))
      let s:fromword = w
      let pri = 1

      " set 'cpo' to include the <CR> - compatibility crap with vi
      let cpo_save = &cpo
      set cpo&vim

      " add the entries to the menu
      for sug in s:suglist
        execute 'anoremenu 1.5.' .. pri .. ' PopUp.' .. s:changeitem .. '.' 
              \ .. escape(sug, ' .') .. ' :call <SID>SpellReplace(' .. pri .. ')<CR>'
        let pri += 1
      endfor

      if !exists("g:menutrans_spell_add_ARG_to_word_list")
        let g:menutrans_spell_add_ARG_to_word_list = 'Add\ "%s"\ to\ Word\ List'
      endif

      let s:additem = printf(g:menutrans_spell_add_ARG_to_word_list, escape(w, ' .'))
      execute 'anoremenu 1.6 PopUp.' .. s:additem .. ' :spellgood ' .. w .. '<CR>'

      if !exists("g:menutrans_spell_ignore_ARG")
        let g:menutrans_spell_ignore_ARG = 'Ignore\ "%s"'
      endif

      let s:ignoreitem = printf(g:menutrans_spell_ignore_ARG, escape(w, ' .'))
      execute 'anoremenu 1.7 PopUp.' .. s:ignoreitem .. ' :spellgood! ' .. w .. '<CR>'

      anoremenu 1.8 PopUp.-SpellSep- :

      " boilerplate: undo vi compat crap
      let &cpo = cpo_save
    endif
  endif

  " put the cursor back where it was when we started just in case
  call cursor(0, curcol)
endfunction

function! s:SpellReplace(n) abort
  let l = getline('.')
  " Move the cursor to the start of the word
  call spellbadword()
  " replace the word
  call setline('.', strpart(l, 0, col('.') - 1) .. s:suglist[a:n - 1]
        \ .. strpart(l, col('.') + len(s:fromword) - 1))
endfunction

function! s:SpellDel() abort
  execute "aunmenu PopUp." .. s:changeitem
  execute "aunmenu PopUp." .. s:additem
  execute "aunmenu PopUp." .. s:ignoreitem
  aunmenu PopUp.-SpellSep-
  let s:changeitem = ''
endfunction

augroup SpellPopupMenu | au!
  au MenuPopup * call <SID>SpellPopup()
augroup END

" vi: et sw=2 sts=-1 fdm=manual
