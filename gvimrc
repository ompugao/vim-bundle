"set guifont=* "set guifont interactively
if has('win32') || has('win64')
  " Windows用
  set guifont=MS_Gothic:h11:b:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Source\ Code\ Pro\ Bold:h13
elseif has("unix")
    " unix固有の設定
    "set guifont=Source\ Code\ Pro\ Bold\ 10
    set guifont=Inconsolata\ Medium\ 13
    "set guifont=IPAゴシック\ Bold\ 14
endif

" ツールバーを削除
set guioptions-=T
"メニューを削除
set guioptions-=m
set vb t_vb=
