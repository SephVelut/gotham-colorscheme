"                      _____ _____ _____ _   _   ___  ___  ___
"                     |  __ \  _  |_   _| | | | / _ \ |  \/  |
"                     | |  \/ | | | | | | |_| |/ /_\ \| .  . |
"                     | | __| | | | | | |  _  ||  _  || |\/| |
"                     | |_\ \ \_/ / | | | | | || | | || |  | |
"                      \____/\___/  \_/ \_| |_/\_| |_/\_|  |_/
"
" URL: https://github.com/whatyouhide/vim-gotham
" Aurhor: Andrea Leopardi <an.leopardi@gmail.com>
" Version: 1.0.0
" License: MIT


" Bootstrap ===================================================================

hi clear
if exists('syntax_on') | syntax reset | endif
set background=dark
let g:colors_name = 'gotham'


" Helper functions =============================================================

" Execute the 'highlight' command with a List of arguments.
function! s:Highlight(args)
  exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:AddGroundValues(accumulator, ground, color)
  let new_list = a:accumulator
  for [where, value] in items(a:color)
    call add(new_list, where . a:ground . '=' . value)
  endfor

  return new_list
endfunction

function! s:Col(group, fg_name, ...)
  " ... = optional bg_name

  let pieces = [a:group]

  if a:fg_name !=# ''
    let pieces = s:AddGroundValues(pieces, 'fg', s:colors[a:fg_name])
  endif

  if a:0 > 0 && a:1 !=# ''
    let pieces = s:AddGroundValues(pieces, 'bg', s:colors[a:1])
  endif

  if exists("a:2") > 0 && a:0 > 0 && a:2 !=# ''
    let pieces = s:AddGroundValues(pieces, '', s:fonts[a:2])
  endif

  call s:Clear(a:group)
  call s:Highlight(pieces)
endfunction

function! s:Attr(group, attr)
  let l:attrs = [a:group, 'term=' . a:attr, 'cterm=' . a:attr, 'gui=' . a:attr]
  call s:Highlight(l:attrs)
endfunction

function! s:Clear(group)
  exec 'highlight clear ' . a:group

endfunction


" Colors ======================================================================

" Let's store all the colors in a dictionary.
let s:colors = {}
let s:fonts = {}

" Base colors.
let s:colors.base0 = { 'gui': '#0c1014', 'cterm': 0 }
let s:colors.base1 = { 'gui': '#11151c', 'cterm': 8 }
let s:colors.base2 = { 'gui': '#091f2e', 'cterm': 10 }
let s:colors.base3 = { 'gui': '#0a3749', 'cterm': 12 }
let s:colors.base4 = { 'gui': '#245361', 'cterm': 11 }
let s:colors.base5 = { 'gui': '#599cab', 'cterm': 14 }
let s:colors.base6 = { 'gui': '#99d1ce', 'cterm': 7 }
let s:colors.base7 = { 'gui': '#d3ebe9', 'cterm': 15 }

" Other colors.
let s:colors.red     = { 'gui': '#c23127', 'cterm': 1  }
let s:colors.orange  = { 'gui': '#d26937', 'cterm': 9  }
let s:colors.yellow  = { 'gui': '#edb443', 'cterm': 3  }
let s:colors.magenta = { 'gui': '#888ca6', 'cterm': 13  }
let s:colors.violet  = { 'gui': '#4e5166', 'cterm': 5  }
let s:colors.blue    = { 'gui': '#195466', 'cterm': 4  }
let s:colors.cyan    = { 'gui': '#33859E', 'cterm': 6  }
let s:colors.green   = { 'gui': '#2aa889', 'cterm': 2  }
let s:colors.white   = { 'gui': '#2aa889', 'cterm': 15  }

" Fonts
let s:fonts.bold = { 'gui': 'bold', 'cterm': 'bold' }

" Native highlighting ==========================================================

let s:background = 'base0'
let s:linenr_background = 'base1'

" Everything starts here.
call s:Col('Normal', 'white', s:background)
"
"" Line, cursor and so on.
call s:Col('Cursor', 'base1', 'base6')
call s:Col('CursorLine', '', 'base1')
call s:Col('CursorColumn', '', 'base1')

" Sign column, line numbers.
call s:Col('LineNr', 'base4', 'base0')
call s:Col('CursorLineNr', 'base5', s:linenr_background)
call s:Col('SignColumn', '', s:linenr_background)
call s:Col('ColorColumn', '', s:linenr_background)

" Visual selection.
call s:Col('Visual', '', 'red')

" Easy-to-guess code elements.
call s:Col('Comment', 'base4')
call s:Col('String', 'yellow')
call s:Col('Number', 'white')
call s:Col('Statement', 'green')
call s:Col('Special', 'blue')
call s:Col('Identifier', 'orange')
highlight clear Function
hi Function ctermfg=2 cterm=bold
call s:Col('Conditional', 'red')
call s:Col('Repeat', 'red')
call s:Col('Structure', 'red')

" Constants, Ruby symbols.
call s:Col('Constant', 'magenta')

" Some HTML tags (<title>, some <h*>s)
call s:Col('Title', 'orange')

" <a> tags.
call s:Col('Underlined', 'yellow')
call s:Attr('Underlined', 'underline')

" Types, HTML attributes, Ruby constants (and class names).
highlight clear Type
hi Type cterm=bold ctermfg=2

" Stuff like 'require' in Ruby.
call s:Col('PreProc', 'violet')

" Tildes on the bottom of the page.
call s:Col('NonText', 'base0')

" Concealed stuff.
call s:Col('Conceal', 'cyan', s:background)

" TODO and similar tags.
call s:Col('Todo', 'magenta', s:background)

" The column separating vertical splits.
call s:Col('VertSplit', 'base4', s:linenr_background)
call s:Col('StatusLineNC', 'base4', 'base2')

" Matching parenthesis.
call s:Col('MatchParen', 'base7', 'red')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:Col('SpecialKey', 'base3')

" Folds.
call s:Col('Folded', 'base6', 'blue')
call s:Col('FoldColumn', 'base5', 'base3')

" Searching.
call s:Col('Search', 'base2', 'yellow')
call s:Attr('IncSearch', 'reverse')

" Popup menu.
call s:Col('Pmenu', 'base6', 'base2')
call s:Col('PmenuSel', 'base7', 'base4')
call s:Col('PmenuSbar', '', 'base2')
call s:Col('PmenuThumb', '', 'base4')

" Command line stuff.
call s:Col('ErrorMsg', 'red', 'base1')
call s:Col('ModeMsg', 'blue')

" Wild menu.
" StatusLine determines the color of the non-active entries in the wild menu.
call s:Col('StatusLine', 'base5', 'base2')
call s:Col('WildMenu', 'base7', 'cyan')

" The 'Hit ENTER to continue prompt'.
call s:Col('Question', 'green')

" Tab line.
call s:Col('TabLineSel', 'base7', 'base4')  " the selected tab
call s:Col('TabLine', 'base6', 'base2')     " the non-selected tabs
call s:Col('TabLineFill', 'base0', 'base0') " the rest of the tab line

" Spelling.
call s:Col('SpellBad', 'base7', 'red')
call s:Col('SpellCap', 'base7', 'blue')
call s:Col('SpellLocal', 'yellow')
call s:Col('SpellRare', 'base7', 'violet')

" Diffing.
call s:Col('DiffAdd', 'base7', 'green')
call s:Col('DiffChange', 'base7', 'blue')
call s:Col('DiffDelete', 'base7', 'red')
call s:Col('DiffText', 'base7', 'cyan')

" Directories (e.g. netrw).
call s:Col('Directory', 'cyan')


" Programming languages and filetypes ==========================================

" Ruby.

if &filetype == "ruby"
  syn match rubyOperator "[~!^&|*/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\*\*\|\.\.\.\|\.\.\|::"
  syn match rubyOperator "->\|-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!="
  syn region rubyBracketOperator matchgroup=rubyOperator start="\%(\w[?!]\=\|[]})]\)\@<=\[\s*" end="\s*]" contains=ALLBUT,@rubyNotTop
  syn match rubyBlockParameter  "\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-x00\x7F]\)*" contained
  syn region rubyBlockParameterList start="\%(\%(\<do\>\|{\)\s*\)\@<=|" end="|" oneline display contains=rubyBlockParameter
  syn match rubyMethArg "\v\(.*\)"
  syn match rubyMethCall "\(def self\..*\)\@<!\w\+\((\)\@="
"syntax match specialSymbols "[(){}\:=><;.&|,\[\]]"
  syn match rubySyms "\(:\)\@<!:\w\+"
endif

syn match specialSymbols "[+()=*{}|,><.\[\]]"
call s:Col('specialSymbols', 'cyan')
call s:Col('rubySyms', 'magenta')
call s:Col('rubyOperator', 'white')
call s:Col('rubyMethCall', 'green')
call s:Col('rubyDefine', 'red')
call s:Col('rubyControl', 'red')
call s:Col('rubyStringDelimiter', 'yellow')
call s:Col('rubyBlockParameter', 'cyan')

" HTML (and often Markdown).
call s:Col('htmlArg', 'blue')
call s:Col('htmlItalic', 'magenta')
call s:Col('htmlBold', 'cyan', '')


" Plugin =======================================================================

" GitGutter
call s:Col('GitGutterAdd', 'green', s:linenr_background)
call s:Col('GitGutterChange', 'cyan', s:linenr_background)
call s:Col('GitGutterDelete', 'orange', s:linenr_background)
call s:Col('GitGutterChangeDelete', 'magenta', s:linenr_background)

" CtrlP
call s:Col('CtrlPNoEntries', 'base7', 'orange') " no entries
call s:Col('CtrlPMatch', 'green')               " matching part
call s:Col('CtrlPPrtBase', 'base4')             " '>>>' prompt
call s:Col('CtrlPPrtText', 'cyan')              " text in the prompt
call s:Col('CtrlPPtrCursor', 'base7')           " cursor in the prompt

" Highlight argument when cursor is above them
"autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
"
"" unite.vim
"call s:Col('UniteGrep', 'base7', 'green')
"let g:unite_source_grep_search_word_highlight = 'UniteGrep'

" Cleanup =====================================================================

unlet s:colors
unlet s:background
unlet s:linenr_background
