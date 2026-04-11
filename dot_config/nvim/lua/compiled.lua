package.preload["config.main"] = package.preload["config.main"] or function(...)
  local vim = _G.vim
  local core = require("config.core")
  local plugins = require("config.plugins")
  local behavior = require("config.behavior")
  local keymaps = require("config.keymaps")
  core.setup()
  if not vim.g.vscode then
    plugins.add()
    vim.lsp.enable({"rust_analyzer", "gopls", "harper_ls", "hls", "racket_langserver", "ocamllsp", "ty", "yamlls", "scheme_langserver"})
    require("mini.basics").setup({options = {extra_ui = true}})
    require("mini.files").setup({})
    require("mini.icons").setup({})
    require("mini.tabline").setup({})
    require("mini.statusline").setup({})
    require("mini.surround").setup({mappings = {add = "ys", delete = "ds", find = "", find_left = "", highlight = "", replace = "cs", suffix_last = "", suffix_next = ""}, search_method = "cover_or_next"})
    vim.keymap.del("x", "ys")
    vim.keymap.set("x", "S", ":<C-u>lua MiniSurround.add('visual')<CR>", {silent = true})
    vim.keymap.set("n", "yss", "ys_", {remap = true})
    require("mini.ai").setup({})
    require("mini.jump2d").setup({})
    require("mini.pairs").setup({})
    require("mini.pick").setup({})
    require("mini.extra").setup({})
    require("which-key").setup({})
    require("blink.cmp").setup({completion = {list = {selection = {preselect = false}}}})
    require("conform").setup({default_format_opts = {lsp_format = "fallback"}})
    vim.lsp.config("racket_langserver", {filetypes = {"racket"}})
    vim.lsp.config("yamlls", {settings = {yaml = {schemaStore = {url = "", enable = false}, schemas = behavior["yaml-schemas"]()}}})
    behavior["setup-paredit-autocmd"]()
    behavior["setup-diagnostics"]()
    keymaps.setup(behavior)
    vim.cmd("colorscheme miniautumn")
    behavior["setup-terminal-send-maps"]()
    return behavior["setup-treesitter-autocmd"]()
  else
    return nil
  end
end
package.preload["config.core"] = package.preload["config.core"] or function(...)
  local vim = _G.vim
  local function setup()
    vim.g["mapleader"] = " "
    vim.g["maplocalleader"] = ","
    vim.o["mouse"] = "a"
    vim.o["mousescroll"] = "ver:25,hor:6"
    vim.o["switchbuf"] = "usetab"
    vim.o["undofile"] = true
    vim.o["shada"] = "'100,<50,s10,:1000,/100,@100,h"
    vim.cmd("filetype plugin indent on")
    if (vim.fn.exists("syntax_on") ~= 1) then
      vim.cmd("syntax enable")
    else
    end
    vim.o["breakindent"] = true
    vim.o["breakindentopt"] = "list:-1"
    vim.o["colorcolumn"] = "+1"
    vim.o["cursorline"] = true
    vim.o["linebreak"] = true
    vim.o["list"] = true
    vim.o["number"] = true
    vim.o["pumborder"] = "single"
    vim.o["pumheight"] = 10
    vim.o["pummaxwidth"] = 100
    vim.o["ruler"] = false
    vim.o["shortmess"] = "CFOSWaco"
    vim.o["showmode"] = false
    vim.o["signcolumn"] = "yes"
    vim.o["splitbelow"] = true
    vim.o["splitkeep"] = "screen"
    vim.o["splitright"] = true
    vim.o["winborder"] = "single"
    vim.o["wrap"] = false
    vim.o["cursorlineopt"] = "screenline,number"
    vim.o["fillchars"] = "eob: ,fold:\226\149\140"
    vim.o["listchars"] = "extends:\226\128\166,nbsp:\226\144\163,precedes:\226\128\166,tab:> "
    vim.o["foldlevel"] = 10
    vim.o["foldmethod"] = "indent"
    vim.o["foldnestmax"] = 10
    vim.o["foldtext"] = ""
    vim.o["autoindent"] = true
    vim.o["expandtab"] = true
    vim.o["formatoptions"] = "rqnl1j"
    vim.o["ignorecase"] = true
    vim.o["incsearch"] = true
    vim.o["infercase"] = true
    vim.o["shiftwidth"] = 2
    vim.o["smartcase"] = true
    vim.o["smartindent"] = true
    vim.o["spelloptions"] = "camel"
    vim.o["tabstop"] = 8
    vim.o["virtualedit"] = "block"
    vim.o["iskeyword"] = "@,48-57,_,192-255,-"
    vim.o["formatlistpat"] = "^\\s*[0-9\\-\\+\\*]\\+[\\.)]*\\s\\+"
    vim.o["complete"] = ".,w,b,kspell"
    vim.o["completeopt"] = "menuone,noselect,fuzzy,nosort"
    vim.o["completetimeout"] = 100
    return nil
  end
  return {setup = setup}
end
package.preload["config.plugins"] = package.preload["config.plugins"] or function(...)
  local vim = _G.vim
  local gh
  local function _2_(repo)
    return ("https://github.com/" .. repo)
  end
  gh = _2_
  local function add()
    return vim.pack.add({gh("nvim-treesitter/nvim-treesitter"), gh("neovim/nvim-lspconfig"), {src = gh("nvim-mini/mini.nvim"), version = "stable"}, {src = gh("saghen/blink.cmp"), version = vim.version.range("1.*")}, gh("folke/which-key.nvim"), gh("tpope/vim-sleuth"), gh("tpope/vim-repeat"), gh("julienvincent/nvim-paredit"), gh("b0o/SchemaStore.nvim"), gh("stevearc/conform.nvim"), gh("hiphish/rainbow-delimiters.nvim")})
  end
  return {add = add}
end
package.preload["config.behavior"] = package.preload["config.behavior"] or function(...)
  local vim = _G.vim
  local function toggle_quickfix()
    local winid = vim.fn.getqflist({winid = true}).winid
    local function _3_()
      if (winid ~= 0) then
        return "cclose"
      else
        return "copen"
      end
    end
    return vim.cmd(_3_())
  end
  local function toggle_locations()
    local winid = vim.fn.getloclist(0, {winid = true}).winid
    local function _4_()
      if (winid ~= 0) then
        return "lclose"
      else
        return "lopen"
      end
    end
    return vim.cmd(_4_())
  end
  local function yaml_schemas()
    return require("schemastore").yaml.schemas()
  end
  local function setup_paredit_autocmd()
    local function _5_()
      require("nvim-paredit").setup({})
      vim.keymap.set("i", "'", "'", {buffer = true})
      return vim.keymap.set("i", "`", "`", {buffer = true})
    end
    return vim.api.nvim_create_autocmd("FileType", {pattern = {"clojure", "racket", "scheme", "lisp"}, callback = _5_})
  end
  local function setup_terminal_send_maps()
    local get_first_term_chan_id
    local function _6_()
      local chan = nil
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if (vim.bo[{buf}].buftype == "terminal") then
          local terminal_id = vim.b[{buf}].terminal_job_id
          if (terminal_id and not chan) then
            chan = terminal_id
          else
          end
        else
        end
      end
      return chan
    end
    get_first_term_chan_id = _6_
    local send_to_term
    local function _9_(lines)
      local chan_id = get_first_term_chan_id()
      if not chan_id then
        return vim.notify("No terminal buffer found. Please open a terminal first (e.g., :term)", vim.log.levels.WARN)
      else
        table.insert(lines, "")
        return vim.fn.chansend(chan_id, lines)
      end
    end
    send_to_term = _9_
    local send_line
    local function _11_()
      return send_to_term({vim.api.nvim_get_current_line()})
    end
    send_line = _11_
    local send_selection
    local function _12_()
      local saved_reg = vim.fn.getreg("t")
      vim.cmd("noau normal! \"<Esc>\"tygv")
      vim.cmd("noau normal! \"ty")
      local text = vim.fn.getreg("t")
      vim.fn.setreg("t", saved_reg)
      return send_to_term(vim.split(text, "\n"))
    end
    send_selection = _12_
    local send_top_sexp
    local function _13_()
      local view = vim.fn.winsaveview()
      local saved_reg = vim.fn.getreg("t")
      local found = vim.fn.search("^(", "bcW")
      if (found == 0) then
        return vim.notify("Top-level S-expression not found!", vim.log.levels.WARN)
      else
        vim.cmd("noau normal! \"ty%")
        local text = vim.fn.getreg("t")
        vim.fn.setreg("t", saved_reg)
        vim.fn.winrestview(view)
        return send_to_term(vim.split(text, "\n"))
      end
    end
    send_top_sexp = _13_
    vim.keymap.set("n", "<LocalLeader>l", send_line, {desc = "Send Line to Term"})
    vim.keymap.set("x", "<LocalLeader>v", send_selection, {desc = "Send Selection to Term"})
    return vim.keymap.set("n", "<LocalLeader>s", send_top_sexp, {desc = "Send Top Sexp to Term"})
  end
  local function setup_treesitter_autocmd()
    local function _15_(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang then
        if vim.treesitter.query.get(lang, "highlights") then
          vim.treesitter.start(args.buf)
        else
        end
        if vim.treesitter.query.get(lang, "indents") then
          vim.opt_local.indentexpr = "v:lua.require(\"nvim-treesitter\").indentexpr()"
        else
        end
        if vim.treesitter.query.get(lang, "folds") then
          vim.opt_local.foldmethod = "expr"
          vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          return nil
        else
          return nil
        end
      else
        return nil
      end
    end
    return vim.api.nvim_create_autocmd("FileType", {group = vim.api.nvim_create_augroup("tree-sitter-enable", {clear = true}), callback = _15_})
  end
  local function setup_diagnostics()
    return vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\238\170\135", [vim.diagnostic.severity.WARN] = "\238\169\172", [vim.diagnostic.severity.INFO] = "\238\169\180", [vim.diagnostic.severity.HINT] = "\239\144\128"}}, virtual_text = {spacing = 4, source = "if_many", prefix = "\239\147\131"}})
  end
  return {["toggle-quickfix"] = toggle_quickfix, ["toggle-locations"] = toggle_locations, ["yaml-schemas"] = yaml_schemas, ["setup-paredit-autocmd"] = setup_paredit_autocmd, ["setup-terminal-send-maps"] = setup_terminal_send_maps, ["setup-treesitter-autocmd"] = setup_treesitter_autocmd, ["setup-diagnostics"] = setup_diagnostics}
end
package.preload["config.keymaps"] = package.preload["config.keymaps"] or function(...)
  local vim = _G.vim
  local function setup(behavior)
    local nmap_leader
    local function _20_(suffix, rhs, desc)
      return vim.keymap.set("n", ("<Leader>" .. suffix), rhs, {desc = desc})
    end
    nmap_leader = _20_
    local xmap_leader
    local function _21_(suffix, rhs, desc)
      return vim.keymap.set("x", ("<Leader>" .. suffix), rhs, {desc = desc})
    end
    xmap_leader = _21_
    local explore_at_file = "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>"
    local pick_added_hunks_buf = "<Cmd>Pick git_hunks path=\"%\" scope=\"staged\"<CR>"
    local pick_workspace_symbols_live = "<Cmd>Pick lsp scope=\"workspace_symbol_live\"<CR>"
    nmap_leader("ed", "<Cmd>lua MiniFiles.open()<CR>", "Directory")
    nmap_leader("ef", explore_at_file, "File directory")
    nmap_leader("ei", "<Cmd>edit $MYVIMRC<CR>", "init.lua")
    nmap_leader("en", "<Cmd>lua MiniNotify.show_history()<CR>", "Notifications")
    nmap_leader("eq", behavior["toggle-quickfix"], "Quickfix list")
    nmap_leader("eQ", behavior["toggle-locations"], "Location list")
    nmap_leader("f/", "<Cmd>Pick history scope=\"/\"<CR>", "\"/\" history")
    nmap_leader("f:", "<Cmd>Pick history scope=\":\"<CR>", "\":\" history")
    nmap_leader("fa", "<Cmd>Pick git_hunks scope=\"staged\"<CR>", "Added hunks (all)")
    nmap_leader("fA", pick_added_hunks_buf, "Added hunks (buf)")
    nmap_leader("fb", "<Cmd>Pick buffers<CR>", "Buffers")
    nmap_leader("fc", "<Cmd>Pick git_commits<CR>", "Commits (all)")
    nmap_leader("fC", "<Cmd>Pick git_commits path=\"%\"<CR>", "Commits (buf)")
    nmap_leader("fd", "<Cmd>Pick diagnostic scope=\"all\"<CR>", "Diagnostic workspace")
    nmap_leader("fD", "<Cmd>Pick diagnostic scope=\"current\"<CR>", "Diagnostic buffer")
    nmap_leader("ff", "<Cmd>Pick files<CR>", "Files")
    nmap_leader("fg", "<Cmd>Pick grep_live<CR>", "Grep live")
    nmap_leader("fG", "<Cmd>Pick grep pattern=\"<cword>\"<CR>", "Grep current word")
    nmap_leader("fh", "<Cmd>Pick help<CR>", "Help tags")
    nmap_leader("fH", "<Cmd>Pick hl_groups<CR>", "Highlight groups")
    nmap_leader("fl", "<Cmd>Pick buf_lines scope=\"all\"<CR>", "Lines (all)")
    nmap_leader("fL", "<Cmd>Pick buf_lines scope=\"current\"<CR>", "Lines (buf)")
    nmap_leader("fm", "<Cmd>Pick git_hunks<CR>", "Modified hunks (all)")
    nmap_leader("fM", "<Cmd>Pick git_hunks path=\"%\"<CR>", "Modified hunks (buf)")
    nmap_leader("fr", "<Cmd>Pick resume<CR>", "Resume")
    nmap_leader("fR", "<Cmd>Pick lsp scope=\"references\"<CR>", "References (LSP)")
    nmap_leader("fs", pick_workspace_symbols_live, "Symbols workspace (live)")
    nmap_leader("fS", "<Cmd>Pick lsp scope=\"document_symbol\"<CR>", "Symbols document")
    nmap_leader("fv", "<Cmd>Pick visit_paths cwd=\"\"<CR>", "Visit paths (all)")
    nmap_leader("fV", "<Cmd>Pick visit_paths<CR>", "Visit paths (cwd)")
    nmap_leader("la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Actions")
    nmap_leader("ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic popup")
    nmap_leader("lf", "<Cmd>lua require(\"conform\").format()<CR>", "Format")
    nmap_leader("li", "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation")
    nmap_leader("lh", "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
    nmap_leader("ll", "<Cmd>lua vim.lsp.codelens.run()<CR>", "Lens")
    nmap_leader("lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
    nmap_leader("lR", "<Cmd>lua vim.lsp.buf.references()<CR>", "References")
    nmap_leader("ls", "<Cmd>lua vim.lsp.buf.definition()<CR>", "Source definition")
    nmap_leader("lt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition")
    xmap_leader("lf", "<Cmd>lua require(\"conform\").format()<CR>", "Format selection")
    nmap_leader("tT", "<Cmd>horizontal term<CR>", "Terminal (horizontal)")
    return nmap_leader("tt", "<Cmd>vertical term<CR>", "Terminal (vertical)")
  end
  return {setup = setup}
end
return require("config.main")