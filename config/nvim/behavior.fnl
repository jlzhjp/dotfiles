(local vim _G.vim)

(fn toggle-quickfix []
  (let [winid (. (vim.fn.getqflist {:winid true}) :winid)]
    (vim.cmd (if (not= winid 0) :cclose :copen))))

(fn toggle-locations []
  (let [winid (. (vim.fn.getloclist 0 {:winid true}) :winid)]
    (vim.cmd (if (not= winid 0) :lclose :lopen))))

(fn yaml-schemas []
  ((. (. (require :schemastore) :yaml) :schemas)))

(fn setup-paredit-autocmd []
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern [:clojure :racket :scheme :lisp]
                                :callback (fn []
                                            ((. (require :nvim-paredit) :setup) {:filetypes [:clojure
                                                                                             :fennel
                                                                                             :scheme
                                                                                             :lisp
                                                                                             :janet
                                                                                             :racket]})
                                            (vim.keymap.set :i "'" "'"
                                                            {:buffer true})
                                            (vim.keymap.set :i "`" "`"
                                                            {:buffer true}))}))

(fn setup-terminal-send-maps []
  (let [get-first-term-chan-id (fn []
                                 (var chan nil)
                                 (each [_ buf (ipairs (vim.api.nvim_list_bufs))]
                                   (when (= (. vim.bo [buf] :buftype) :terminal)
                                     (let [terminal-id (. vim.b [buf]
                                                          :terminal_job_id)]
                                       (when (and terminal-id (not chan))
                                         (set chan terminal-id)))))
                                 chan)
        send-to-term (fn [lines]
                       (let [chan-id (get-first-term-chan-id)]
                         (if (not chan-id)
                             (vim.notify "No terminal buffer found. Please open a terminal first (e.g., :term)"
                                         vim.log.levels.WARN)
                             (do
                               (table.insert lines "")
                               (vim.fn.chansend chan-id lines)))))
        send-line (fn []
                    (send-to-term [(vim.api.nvim_get_current_line)]))
        send-selection (fn []
                         (let [saved-reg (vim.fn.getreg :t)]
                           (vim.cmd "noau normal! \"<Esc>\"tygv")
                           (vim.cmd "noau normal! \"ty")
                           (let [text (vim.fn.getreg :t)]
                             (vim.fn.setreg :t saved-reg)
                             (send-to-term (vim.split text "\n")))))
        send-top-sexp (fn []
                        (let [view (vim.fn.winsaveview)
                              saved-reg (vim.fn.getreg :t)
                              found (vim.fn.search "^(" :bcW)]
                          (if (= found 0)
                              (vim.notify "Top-level S-expression not found!"
                                          vim.log.levels.WARN)
                              (do
                                (vim.cmd "noau normal! \"ty%")
                                (let [text (vim.fn.getreg :t)]
                                  (vim.fn.setreg :t saved-reg)
                                  (vim.fn.winrestview view)
                                  (send-to-term (vim.split text "\n")))))))]
    (vim.keymap.set :n :<LocalLeader>l send-line {:desc "Send Line to Term"})
    (vim.keymap.set :x :<LocalLeader>v send-selection
                    {:desc "Send Selection to Term"})
    (vim.keymap.set :n :<LocalLeader>s send-top-sexp
                    {:desc "Send Top Sexp to Term"})))

(fn setup-treesitter-autocmd []
  (vim.api.nvim_create_autocmd :FileType
                               {:group (vim.api.nvim_create_augroup :tree-sitter-enable
                                                                    {:clear true})
                                :callback (fn [args]
                                            (let [lang (vim.treesitter.language.get_lang args.match)]
                                              (when lang
                                                (when (vim.treesitter.query.get lang
                                                                                :highlights)
                                                  (vim.treesitter.start args.buf))
                                                (when (vim.treesitter.query.get lang
                                                                                :indents)
                                                  (set vim.opt_local.indentexpr
                                                       "v:lua.require(\"nvim-treesitter\").indentexpr()"))
                                                (when (vim.treesitter.query.get lang
                                                                                :folds)
                                                  (set vim.opt_local.foldmethod
                                                       :expr)
                                                  (set vim.opt_local.foldexpr
                                                       "v:lua.vim.treesitter.foldexpr()")))))}))

(fn setup-diagnostics []
  (vim.diagnostic.config {:signs {:text {vim.diagnostic.severity.ERROR ""
                                         vim.diagnostic.severity.WARN ""
                                         vim.diagnostic.severity.INFO ""
                                         vim.diagnostic.severity.HINT ""}}
                          :virtual_text {:spacing 4
                                         :source :if_many
                                         :prefix ""}}))

{: toggle-quickfix
 : toggle-locations
 : yaml-schemas
 : setup-paredit-autocmd
 : setup-terminal-send-maps
 : setup-treesitter-autocmd
 : setup-diagnostics}
