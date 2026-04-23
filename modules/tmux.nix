_:

{
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    escapeTime = 10;
    focusEvents = true;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "tmux-256color";

    extraConfig = ''
      set -g renumber-windows on
      set -g set-clipboard on

      # Enable true color when the outer terminal supports it.
      set -as terminal-features ",xterm-256color:RGB"

      # Keep new splits in the current working directory.
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Vim-friendly split keys.
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      # Reload config without restarting tmux.
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded"

      # Vim-style pane navigation.
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes with Shift + hjkl.
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Alt-h / Alt-l moves between windows. Tab jumps to the last window.
      bind -n M-h previous-window
      bind -n M-l next-window
      bind Tab last-window

      # Vim-like selection inside copy mode.
      bind Enter copy-mode
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi V send -X select-line
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi q send -X cancel

      bind q display-panes
      bind z resize-pane -Z
      bind x kill-pane
      bind X kill-window
      bind $ command-prompt -I "#S" "rename-session '%%'"
      bind , command-prompt -I "#W" "rename-window '%%'"

      # Disable visual bells and activity notifications.
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      setw -g clock-mode-colour yellow
      setw -g mode-style 'fg=black bg=red bold'

      set -g pane-border-style 'fg=red'
      set -g pane-active-border-style 'fg=yellow'

      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=red'

      set -g status-left ""
      set -g status-left-length 10

      set -g status-right-style 'fg=black bg=yellow'
      set -g status-right '%Y-%m-%d %H:%M '
      set -g status-right-length 50

      setw -g window-status-current-style 'fg=black bg=red'
      setw -g window-status-current-format ' #I #W #F '

      setw -g window-status-style 'fg=red bg=black'
      setw -g window-status-format ' #I #[fg=white]#W #[fg=yellow]#F '

      setw -g window-status-bell-style 'fg=yellow bg=red bold'

      set -g message-style 'fg=yellow bg=red bold'
    '';
  };
}
