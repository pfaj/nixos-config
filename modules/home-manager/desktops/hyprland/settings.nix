{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "ags -b hypr"

      "sleep 1; discord"
      "sleep 1; steam"
      "sleep 1; easyeffects"
    ];

    general = {
      layout = "dwindle";
      resize_on_border = true;
      no_cursor_warps = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      layers_hog_keyboard_focus = false;

      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;
    };

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        drag_lock = true;
      };
      sensitivity = 0;
      float_switch_override_focus = 2;
    };

    binds = {
      allow_workspace_cycles = true;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_direction_lock = false;
      workspace_swipe_forever = true;
      workspace_swipe_numbered = true;
    };

    decoration = {
      drop_shadow = true;
      shadow_range = 8;
      shadow_render_power = 2;
      "col.shadow" = "rgba(00000044)";
      dim_inactive = false;

      blur = {
        enabled = true;
        size = 8;
        passes = 3;
        new_optimizations = true;
        noise = 0.01;
        contrast = 0.9;
        brightness = 0.8;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.05"
        "easeOutSine, 0.61, 1, 0.88, 1"
        "easeOutQuad, 0.5, 1, 0.89, 1"
        "easeOutCubic, 0.33, 1, 0.68, 1"
        "easeOutQuart, 0.25, 1, 0.5, 1"
        "easeOutQuint, 0.22, 1, 0.36, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
      ];

      animation = [
        "windows, 1, 3, easeOutExpo, popin 75%"
        "border, 1, 4, easeOutCubic"
        "fade, 1, 2, easeOutCubic"
        "fadeSwitch, 1, 1, easeOutCubic"
        "fadeDim, 1, 1, easeOutCubic"
        "workspaces, 1, 6, easeOutExpo"
        "specialWorkspace, 1, 4, easeOutExpo"
      ];
    };

    plugin = {
      hyprbars = {
        bar_color = "rgb(2a2a2a)";
        bar_height = 28;
        col_text = "rgba(ffffffdd)";
        bar_text_size = 11;
        bar_text_font = "Roboto Regular";

        hyprbars-button = [
          "rgb(eeee11), 18, , hyprctl dispatch fullscreen 1"
        ];
      };
    };

    windowrule = let
      float = regex: "float, ^(${regex})$";
      opacity = value: regex: "opacity ${value} ${value}, ^(${regex})$";
      size = value: regex: "size ${value} ${value}, ^(${regex})$";
      workspace = value: regex: "workspace ${value}, ^(${regex})$";
      pin = regex: "pin, ^(${regex})$";
      center = regex: "center, ^(${regex})$";
    in [
      (workspace "1" ".*brave.*")
      (workspace "2 silent" ".*discord.*")
      (workspace "5 silent" "steam")
      (workspace "10 silent" ".*easyeffects.*")

      (float "xdg-desktop-portal")
      (float "xdg-desktop-portal-gtk")

      (opacity "0.95" "chromium")
      (opacity "0.95" ".*code.*")
      (opacity "0.95" "WebCord")
      (opacity "0.95" "steam")
      (opacity "0.95" ".*brave.*")
      (opacity "0.95" "easyeffects")

      (float "alacritty-floating")
      (size "60%" "alacritty-floating")
      (center "alacritty-floating")

      (float "org.kde.dolphin")
      (size "60%" "org.kde.dolphin")
      (center "org.kde.dolphin")

      (float "gnome-system-monitor")
      (opacity "0.95" "gnome-system-monitor")
      (size "60%" "gnome-system-monitor")
      (pin "gnome-system-monitor")
      (center "gnome-system-monitor")
    ];

    layerrule = let
      makeRule = type: ["blur, ${type}" "ignorealpha 0.4, ${type}"];
      types = [
        "anyrun"
        "gtk-layer-shell"
        "dock1"
        "notifications1"
        "corner1topleft"
        "corner1topright"
        "corner1bottomleft"
        "corner1bottomright"
        "bar1"
        "indicator1"
        "dock0"
        "notifications0"
        "corner0topleft"
        "corner0topright"
        "corner0bottomleft"
        "corner0bottomright"
        "bar0"
        "indicator0"
        "dashboard"
        "quicksettings"
        "powermenu"
        "overview"
        "applauncher"
      ];
    in
      builtins.concatMap makeRule types;

    bind = [
      # management binds
      "SUPER, Q, killactive"
      "SUPER, M, exit"
      "SUPER, V, togglefloating"
      "SUPER, R, exec, anyrun"
      "SUPER, W, pin"
      "SUPER, P, pseudo" # dwindle
      "SUPER, H, togglesplit" # dwindle
      "SUPER, F, fullscreen, 0"
      "SUPER SHIFT, F, fullscreen, 1"
      "SUPER ALT, F, fakefullscreen"

      # application binds
      "SUPER, RETURN, exec, alacritty --class=alacritty-floating"
      "SUPER SHIFT, RETURN, exec, alacritty"
      "SUPER SHIFT, T, exec, alacritty --class=alacritty-floating"
      "SUPER SHIFT, E, exec, dolphin"
      "SUPER SHIFT, B, exec, brave"
      "SUPER, grave, exec, gnome-system-monitor"

      # window binds
      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"

      "SUPER SHIFT, left, movewindow, l"
      "SUPER SHIFT, right, movewindow, r"
      "SUPER SHIFT, up, movewindow, u"
      "SUPER SHIFT, down, movewindow, d"

      # workspace binds
      "SUPER ALT, left, workspace, -1"
      "SUPER ALT, right, workspace, +1"
      "SUPER SHIFT ALT, left, movetoworkspace, -1"
      "SUPER SHIFT ALT, right, movetoworkspace, +1"

      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"
      "SUPER, S, togglespecialworkspace"

      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"
      "SUPER SHIFT, S, movetoworkspace, special"

      # scroll through workspaces using mouse wheel
      "SUPER, mouse_down, workspace, m-1"
      "SUPER, mouse_up, workspace, m+1"

      # ags
      "CTRL SHIFT, R, exec, ags -b hypr quit; ags -b hypr" # restart

      #bind=SUPER, R,       exec, ags -t applauncher
      ", XF86PowerOff, exec, ags -b hypr -t powermenu"
      "SUPER, Tab, exec, ags -b hypr -t overview"

      # screenshot & screenrecord
      ", XF86Launch4, exec, ags -b hypr -r 'recorder.start()'"
      ", Print, exec, ags -b hypr -r 'recorder.screenshot()'"
      "SHIFT, Print, exec, ags -b hypr -r 'recorder.screenshot(true)'"
      "CTRL, Print, exec, grimblast copy area"
    ];

    bindm = [
      # move/resize window with mouse buttons
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bindle = let
      e = "exec, ags -b hypr -r";
    in [
      ",XF86MonBrightnessUp, ${e} 'brightness.screen += 0.05; indicator.display()'"
      ",XF86MonBrightnessDown, ${e} 'brightness.screen -= 0.05; indicator.display()'"
      ",XF86KbdBrightnessUp, ${e} 'brightness.kbd++; indicator.kbd()'"
      ",XF86KbdBrightnessDown, ${e} 'brightness.kbd--; indicator.kbd()'"
      ",XF86AudioRaiseVolume, ${e} 'audio.speaker.volume += 0.05; indicator.speaker()'"
      ",XF86AudioLowerVolume,${e} 'audio.speaker.volume -= 0.05; indicator.speaker()'"
    ];

    bindl = let
      e = "exec, ags -b hypr -r";
    in [
      ",XF86AudioPlay, ${e} 'mpris?.playPause()'"
      ",XF86AudioStop, ${e} 'mpris?.stop()'"
      ",XF86AudioPause, ${e} 'mpris?.pause()'"
      ",XF86AudioPrev, ${e} 'mpris?.previous()'"
      ",XF86AudioNext, ${e} 'mpris?.next()'"
      ",XF86AudioMicMute, ${e} 'audio.microphone.isMuted = !audio.microphone.isMuted'"
    ];
  };
}
