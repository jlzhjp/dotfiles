(local vim _G.vim)

(fn setup [behavior]
  (let [nmap-leader (fn [suffix rhs desc]
                      (vim.keymap.set "n" (.. "<Leader>" suffix) rhs {:desc desc}))
        xmap-leader (fn [suffix rhs desc]
                      (vim.keymap.set "x" (.. "<Leader>" suffix) rhs {:desc desc}))
        explore-at-file "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>"
        pick-added-hunks-buf "<Cmd>Pick git_hunks path=\"%\" scope=\"staged\"<CR>"
        pick-workspace-symbols-live "<Cmd>Pick lsp scope=\"workspace_symbol_live\"<CR>"]
    (nmap-leader "ed" "<Cmd>lua MiniFiles.open()<CR>" "Directory")
    (nmap-leader "ef" explore-at-file "File directory")
    (nmap-leader "ei" "<Cmd>edit $MYVIMRC<CR>" "init.lua")
    (nmap-leader "en" "<Cmd>lua MiniNotify.show_history()<CR>" "Notifications")
    (nmap-leader "eq" (. behavior :toggle-quickfix) "Quickfix list")
    (nmap-leader "eQ" (. behavior :toggle-locations) "Location list")

    (nmap-leader "f/" "<Cmd>Pick history scope=\"/\"<CR>" "\"/\" history")
    (nmap-leader "f:" "<Cmd>Pick history scope=\":\"<CR>" "\":\" history")
    (nmap-leader "fa" "<Cmd>Pick git_hunks scope=\"staged\"<CR>" "Added hunks (all)")
    (nmap-leader "fA" pick-added-hunks-buf "Added hunks (buf)")
    (nmap-leader "fb" "<Cmd>Pick buffers<CR>" "Buffers")
    (nmap-leader "fc" "<Cmd>Pick git_commits<CR>" "Commits (all)")
    (nmap-leader "fC" "<Cmd>Pick git_commits path=\"%\"<CR>" "Commits (buf)")
    (nmap-leader "fd" "<Cmd>Pick diagnostic scope=\"all\"<CR>" "Diagnostic workspace")
    (nmap-leader "fD" "<Cmd>Pick diagnostic scope=\"current\"<CR>" "Diagnostic buffer")
    (nmap-leader "ff" "<Cmd>Pick files<CR>" "Files")
    (nmap-leader "fg" "<Cmd>Pick grep_live<CR>" "Grep live")
    (nmap-leader "fG" "<Cmd>Pick grep pattern=\"<cword>\"<CR>" "Grep current word")
    (nmap-leader "fh" "<Cmd>Pick help<CR>" "Help tags")
    (nmap-leader "fH" "<Cmd>Pick hl_groups<CR>" "Highlight groups")
    (nmap-leader "fl" "<Cmd>Pick buf_lines scope=\"all\"<CR>" "Lines (all)")
    (nmap-leader "fL" "<Cmd>Pick buf_lines scope=\"current\"<CR>" "Lines (buf)")
    (nmap-leader "fm" "<Cmd>Pick git_hunks<CR>" "Modified hunks (all)")
    (nmap-leader "fM" "<Cmd>Pick git_hunks path=\"%\"<CR>" "Modified hunks (buf)")
    (nmap-leader "fr" "<Cmd>Pick resume<CR>" "Resume")
    (nmap-leader "fR" "<Cmd>Pick lsp scope=\"references\"<CR>" "References (LSP)")
    (nmap-leader "fs" pick-workspace-symbols-live "Symbols workspace (live)")
    (nmap-leader "fS" "<Cmd>Pick lsp scope=\"document_symbol\"<CR>" "Symbols document")
    (nmap-leader "fv" "<Cmd>Pick visit_paths cwd=\"\"<CR>" "Visit paths (all)")
    (nmap-leader "fV" "<Cmd>Pick visit_paths<CR>" "Visit paths (cwd)")

    (nmap-leader "la" "<Cmd>lua vim.lsp.buf.code_action()<CR>" "Actions")
    (nmap-leader "ld" "<Cmd>lua vim.diagnostic.open_float()<CR>" "Diagnostic popup")
    (nmap-leader "lf" "<Cmd>lua require(\"conform\").format()<CR>" "Format")
    (nmap-leader "li" "<Cmd>lua vim.lsp.buf.implementation()<CR>" "Implementation")
    (nmap-leader "lh" "<Cmd>lua vim.lsp.buf.hover()<CR>" "Hover")
    (nmap-leader "ll" "<Cmd>lua vim.lsp.codelens.run()<CR>" "Lens")
    (nmap-leader "lr" "<Cmd>lua vim.lsp.buf.rename()<CR>" "Rename")
    (nmap-leader "lR" "<Cmd>lua vim.lsp.buf.references()<CR>" "References")
    (nmap-leader "ls" "<Cmd>lua vim.lsp.buf.definition()<CR>" "Source definition")
    (nmap-leader "lt" "<Cmd>lua vim.lsp.buf.type_definition()<CR>" "Type definition")

    (xmap-leader "lf" "<Cmd>lua require(\"conform\").format()<CR>" "Format selection")

    (nmap-leader "tT" "<Cmd>horizontal term<CR>" "Terminal (horizontal)")
    (nmap-leader "tt" "<Cmd>vertical term<CR>" "Terminal (vertical)")))

{: setup}
