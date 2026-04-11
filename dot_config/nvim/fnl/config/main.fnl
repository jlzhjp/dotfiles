(local vim _G.vim)
(local core (include "config.core"))
(local plugins (include "config.plugins"))
(local behavior (include "config.behavior"))
(local keymaps (include "config.keymaps"))

((. core :setup))

(when (not vim.g.vscode)
  ((. plugins :add))

  (vim.lsp.enable
    ["rust_analyzer"
     "gopls"
     "harper_ls"
     "hls"
     "racket_langserver"
     "ocamllsp"
     "ty"
     "yamlls"
     "scheme_langserver"])

  ((. (require :mini.basics) :setup) {:options {:extra_ui true}})
  ((. (require :mini.files) :setup) {})
  ((. (require :mini.icons) :setup) {})
  ((. (require :mini.tabline) :setup) {})
  ((. (require :mini.statusline) :setup) {})
  ((. (require :mini.surround) :setup)
   {:mappings {:add "ys"
               :delete "ds"
               :find ""
               :find_left ""
               :highlight ""
               :replace "cs"
               :suffix_last ""
               :suffix_next ""}
    :search_method "cover_or_next"})

  (vim.keymap.del "x" "ys")
  (vim.keymap.set "x" "S" ":<C-u>lua MiniSurround.add('visual')<CR>" {:silent true})
  (vim.keymap.set "n" "yss" "ys_" {:remap true})

  ((. (require :mini.ai) :setup) {})
  ((. (require :mini.jump2d) :setup) {})
  ((. (require :mini.pairs) :setup) {})
  ((. (require :mini.pick) :setup) {})
  ((. (require :mini.extra) :setup) {})
  ((. (require :mini.notify) :setup) {})
  ((. (require :which-key) :setup) {})
  ((. (require :blink.cmp) :setup) {:completion {:list {:selection {:preselect false}}}})
  ((. (require :conform) :setup) {:default_format_opts {:lsp_format "fallback"}})

  (when vim.g.fennel_bootstrap_compiled
    (vim.schedule
      (fn []
        (vim.notify
          (.. "Recompiled Fennel config from " vim.g.fennel_bootstrap_compiled_count " source files")
          vim.log.levels.INFO
          {:title "Neovim bootstrap"}))))

  (vim.lsp.config "racket_langserver" {:filetypes ["racket"]})
  (vim.lsp.config
    "yamlls"
    {:settings
     {:yaml
      {:schemaStore {:enable false :url ""}
       :schemas ((. behavior :yaml-schemas))}}})

  ((. behavior :setup-paredit-autocmd))
  ((. behavior :setup-diagnostics))
  ((. keymaps :setup) behavior)
  (vim.cmd "colorscheme miniautumn")
  ((. behavior :setup-terminal-send-maps))
  ((. behavior :setup-treesitter-autocmd)))
