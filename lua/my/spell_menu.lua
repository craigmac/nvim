-- yanked from $VIMRUNTIME/menu.vim - eventually translate to lua and make z= do this default menu instead
vim.cmd([[
if has("spell")
  " Spell suggestions in a popup menu.
  func s:SpellPopup()
    if exists("s:changeitem") && s:changeitem != ''
      call <SID>SpellDel()
    endif

    " Return quickly if spell checking is not enabled.
    if !&spell || &spelllang == ''
      return
    endif

    let curcol = col('.')
    let [w, a] = spellbadword()
    if col('.') > curcol " don't use word after the cursor
      let w = ''
    endif
    if w != ''
      if a == 'caps'
        let s:suglist = [substitute(w, '.*', '\u&', '')]
      else
        let s:suglist = spellsuggest(w, 10)
      endif
      if len(s:suglist) > 0
        if !exists("g:menutrans_spell_change_ARG_to")
          let g:menutrans_spell_change_ARG_to = 'Change\ "%s"\ to'
        endif
        let s:changeitem = printf(g:menutrans_spell_change_ARG_to, escape(w, ' .'))
        let s:fromword = w
        let pri = 1
        " set 'cpo' to include the <CR>
        let cpo_save = &cpo
        set cpo&vim
        for sug in s:suglist
          exe 'anoremenu 1.5.' . pri . ' PopUp.' . s:changeitem . '.' . escape(sug, ' .')
                \ . ' :call <SID>SpellReplace(' . pri . ')<CR>'
          let pri += 1
        endfor

        if !exists("g:menutrans_spell_add_ARG_to_word_list")
          let g:menutrans_spell_add_ARG_to_word_list = 'Add\ "%s"\ to\ Word\ List'
        endif
        let s:additem = printf(g:menutrans_spell_add_ARG_to_word_list, escape(w, ' .'))
        exe 'anoremenu 1.6 PopUp.' . s:additem . ' :spellgood ' . w . '<CR>'

        if !exists("g:menutrans_spell_ignore_ARG")
          let g:menutrans_spell_ignore_ARG = 'Ignore\ "%s"'
        endif
        let s:ignoreitem = printf(g:menutrans_spell_ignore_ARG, escape(w, ' .'))
        exe 'anoremenu 1.7 PopUp.' . s:ignoreitem . ' :spellgood! ' . w . '<CR>'

        anoremenu 1.8 PopUp.-SpellSep- :
        let &cpo = cpo_save
      endif
    endif
    call cursor(0, curcol)      " put the cursor back where it was
  endfunc

  func s:SpellReplace(n)
    let l = getline('.')
    " Move the cursor to the start of the word.
    call spellbadword()
    call setline('.', strpart(l, 0, col('.') - 1) . s:suglist[a:n - 1]
          \ . strpart(l, col('.') + len(s:fromword) - 1))
  endfunc

  func s:SpellDel()
    exe "aunmenu PopUp." . s:changeitem
    exe "aunmenu PopUp." . s:additem
    exe "aunmenu PopUp." . s:ignoreitem
    aunmenu PopUp.-SpellSep-
    let s:changeitem = ''
  endfun

  augroup SpellPopupMenu
    au! MenuPopup * call <SID>SpellPopup()
  augroup END
endif
]])
