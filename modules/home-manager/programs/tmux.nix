{pkgs, ...}: {
  home.packages = with pkgs.tmuxPlugins; [
    catppuccin
  ];

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    shortcut = "a";
    escapeTime = 0;
    tmuxinator.enable = true;
    extraConfig = ''
      run-shell '${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux'
      # Plugins
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"

      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"

      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W"

      set -g status-right-length 100
      set -g @catppuccin_status_modules_right "#{E:@catppuccin_status_application}#{E:@catppuccin_status_session}"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"

      set -g @catppuccin_directory_text "#{pane_current_path}"

      # Other settings
      set-option -g status-position top
      setw -g mouse on

    '';
  };
}
