local dashboard = require("dashboard")

dashboard.custom_header = {
  [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
  [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
  [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
  [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
  [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
  [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}
-- dashboard.custom_header = {
--   [[                                   :                                              ]],
--   [[  L.                      ,;      t#,                                             ]],
--   [[  EW:        ,ft        f#i      ;##W.                  t                         ]],
--   [[  E##;       t#E      .E#t      :#L:WE                  Ej             ..       : ]],
--   [[  E###t      t#E     i#W,      .KG  ,#D    t      .DD.  E#,           ,W,     .Et ]],
--   [[  E#fE#f     t#E    L#D.       EE    ;#f   EK:   ,WK.   E#t          t##,    ,W#t ]],
--   [[  E#t D#G    t#E  :K#Wfff;    f#.     t#i  E#t  i#D     E#t         L###,   j###t ]],
--   [[  E#t  f#E.  t#E  i##WLLLLt   :#G     GK   E#t j#f      E#t       .E#j##,  G#fE#t ]],
--   [[  E#t   t#K: t#E   .E#L        ;#L   LW.   E#tL#i       E#t      ;WW; ##,:K#i E#t ]],
--   [[  E#t    ;#W,t#E     f#E:       t#f f#:    E#WW,        E#t     j#E.  ##f#W,  E#t ]],
--   [[  E#t     :K#D#E      ,WW;       f#D#;     E#K:         E#t   .D#L    ###K:   E#t ]],
--   [[  E#t      .E##E       .D#;       G#t      ED.          E#t  :K#t     ##D.    E#t ]],
--   [[  ..         G#E         tt        t       t            E#t  ...      #G      ..  ]],
--   [[              fE                                        ,;.           j           ]],
--   [[               ,                                                                  ]],
-- }
dashboard.default_executive = 'telescope'

icon_hl = { fg = "#dc5284" }
dashboard.custom_center = {
  { shortcut = 'a', icon = '  ', icon_hl = icon_hl, desc = 'Find File          ', action = 'Telescope find_files' },
  { shortcut = 'd', icon = '  ', icon_hl = icon_hl, desc = 'Search Text        ', action = 'Telescope live_grep' },
  { shortcut = 'b', icon = '  ', icon_hl = icon_hl, desc = 'Recent Files       ', action = 'Telescope oldfiles' },
  { shortcut = 'e', icon = '  ', icon_hl = icon_hl, desc = 'Config             ',
    action = 'edit ~/.config/nvim/init.lua' },
  { shortcut = 'f', icon = '  ', icon_hl = icon_hl, desc = 'Git                ', action = 'Telescope git_branches' },
  { shortcut = 'n', icon = '  ', icon_hl = icon_hl, desc = 'New file           ', action = 'edit ./tmp' }
}
vim.cmd('highlight DashboardHeader guifg=#dc5284')
