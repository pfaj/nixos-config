{ inputs, pkgs, config, lib, self, ... }:
{
    imports = (with inputs.self.homeManagerModules; [
        xdg

        programs.anyrun # runner
        #programs.mako # notification daemon
    ]) ++ ([
        inputs.hyprland.homeManagerModules.default
    ]);

    home = {
        sessionVariables = {
            XDG_CURRENT_DESKTOP = "Hyprland";
            XDG_SESSION_TYPE = "wayland";
            XDG_SESSION_DESKTOP = "Hyprland";

            QT_AUTO_SCREEN_SCALE_FACTOR = "1";
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

            SDL_VIDEODRIVER = "wayland";
            _JAVA_AWT_WM_NONREPARENTING = "1";
            CLUTTER_BACKEND = "wayland";
            GDK_BACKEND = "wayland,x11";
        };

        packages = with pkgs; [
            swww
            networkmanagerapplet
            dolphin
            ark
            xfce.thunar
            gnome.gnome-system-monitor

            swayidle
            swaylock
            wlogout
            wl-clipboard
            wlr-randr

            inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

            inputs.ags.packages.${pkgs.system}.default
            hyprpicker
            brightnessctl
            glib

            #eww-wayland
            #hyprland-workspaces
        ];
    };

    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        enableNvidiaPatches = true;
        extraConfig = builtins.readFile ./hyprland.conf;

#         settings = {
#         };

#         config = {
#              # make sure left monitor is primary
#              exec-once = [
#                  "wlr-randr --output HDMI-A-1 --off && sleep 1 && wlr-randr --output HDMI-A-1 --on --pos 1921,0" # make sure left monitor is primary
#
#                  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # import dbus env
#                  "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # import systemctl env
#
#                  "/nix/store/$(ls -la /nix/store | grep polkit-kde-agent | grep '^d' | awk '{print $9}')/libexec/polkit-kde-authentication-agent-1" # Start polkit
#                  "nm-applet --indicator" # NetworkManager system tray applet
#                  "swww init" # activate wallpaper
#                  #swww img /mnt/LinuxExpansion/Places/Images/cool_wallpaper.jpg
#                  "eww -c ~/.config/eww/bar open-many bar_1 top_bar_1 bar_2" # activate custom eww bar
#
#                  # autostart programs
#                  "sleep 1; webcord"
#                  "sleep 1; spotifywm"
#                  "sleep 1; steam"
#                  "sleep 1; easyeffects"
#              ];
#
#              misc = {
#                  animate_manual_resizes = false;
#                  animate_mouse_windowdragging = false;
#              };
#
#              general = {
#                  gaps_in = 2;
#                  gaps_out = 4;
#                  border_size = 2;
#                  col = {
#                      active_border = "";
#                      inactive_border = "";
#                  };
#                  layout = "dwindle";
#              };
#
#              input = {
#                  kb_layout = "us";
#                  kb_variant = "";
#                  kb_model = "";
#                  kb_options = "";
#                  kb_rules = "";
#
#                  numlock_by_default = true;
#
#                  follow_mouse = 1;
#
#                  touchpad = {
#                      natural_scroll = false;
#                  };
#
#                  sensitivity = 0.0;
#              };
#
#              decoration = {
#                  rounding = 8;
#                  fullscreen_opacity = 1;
#
#                  # blur
#                  blur = true;
#                  blur_size = 8;
#                  blur_passes = 3;
#                  blur_ignore_opacity = true;
#                  blur_new_optimizations = true;
#
#                  # drop shadow
#                  drop_shadow = true;
#                  shadow_range = 48;
#                  shadow_render_power = 3;
#                  col = {
#                      shadow = "rgba(000066)";
#                      shadow_inactive = "rgba(000044)";
#                  };
#              };
#
#              animations = {
#                  enabled = true;
#
#                  bezier = [
#                      "myBezier, 0.05, 0.9, 0.1, 1.05"
#                      "easeOutSine, 0.61, 1, 0.88, 1"
#                      "easeOutQuad, 0.5, 1, 0.89, 1"
#                      "easeOutCubic, 0.33, 1, 0.68, 1"
#                      "easeOutQuart, 0.25, 1, 0.5, 1"
#                      "easeOutQuint, 0.22, 1, 0.36, 1"
#                      "easeOutExpo, 0.16, 1, 0.3, 1s"
#                      "easeOutCirc, 0, 0.55, 0.45, 1"
#                  ];
#
#                  animation = [
#                      "windows, 1, 3, easeOutExpo, popin 75%"
#                      "border, 1, 4, easeOutCubic"
#                      "fade, 1, 2, easeOutCubic"
#                      "fadeSwitch, 1, 1, easeOutCubic"
#                      "fadeDim, 1, 1, easeOutCubic"
#                      "workspaces, 1, 6, easeOutExpo"
#                      "specialWorkspace, 1, 4, easeOutExpo"
#                  ];
#              };
#
#              dwindle = {
#                  pseudotile = true;
#                  preserve_split = true;
#              };
#
#              master = {
#                  new_is_master = true;
#              };
#
#              misc = {
#                  disable_hyprland_logo = true;
#                  disable_splash_rendering = true;
#                  vrr = 1;
#                  no_direct_scanout = true;
#              };
#
#              windowrule = [
#                  "workspace 2 silent, WebCord"
#                  "workspace 4 silent, ^(.*whatsapp.*)$"
#                  "workspace 5 silent, steam"
#                  "workspace 10 silent, easyeffects"
#
#                  "opacity 0.95 0.95, chromium"
#                  "opacity 0.95 0.95, ^(.*code.*)$"
#                  "opacity 0.95 0.95, WebCord"
#                  "opacity 0.95 0.95, steam"
#                  "opacity 0.95 0.95, ^(.*brave.*)$"
#                  "opacity 0.95 0.95, ^(.*whatsapp.*)$"
#                  "opacity 0.95 0.95, easyeffects"
#
#                  "noanim, ^(eww)$"
#                  "noblur, ^(GLava)$"
#                  "nofocus, ^(GLava)$"
#                  "noborder, ^(GLava)$"
#                  "noshadow, ^(GLava)$"
#                  "float, ^(GLava)$"
#                  "pin, ^(GLava)$"
#                  "float, kitty-floating"
#                  "size 60% 60%, kitty-floating"
#                  "float, org.kde.dolphin"
#              ];
#
#              windowrulev2 = [
#                  "workspace 3 slient, title:Spotify"
#                  "opacity 0.95 0.95, title:Spotify"
#              ];
#
#              bind = [
#                  "SUPER, Q, killactive,"
#                  "SUPER, M, exit,"
#                  "SUPER, V, togglefloating,"
#                  "SUPER, R, exec, anyrun"
#                  "SUPER, P, pseudo, # dwindle"
#                  "SUPER, H, togglesplit, # dwindle"
#                  "SUPER, F, fullscreen,"
#                  "SUPER SHIFT, F, exec, hyprctl dispatch fullscreen 1"
#                  "SUPER ALT, F, exec, hyprctl dispatch fullscreen 3"
#                  "SUPER, W, pin,"
#
#                  # application binds
#                  "SUPER, RETURN, exec, kitty --class=kitty-floating"
#                  "SUPER SHIFT, RETURN, exec, kitty"
#                  "SUPER SHIFT, E, exec, dolphin"
#                  "SUPER SHIFT, B, exec, brave"
#                  "SUPER, grave, exec, ksysguard"
#
#                  # move focus with mod + arrow keys
#                  "SUPER, left, movefocus, l"
#                  "SUPER, right, movefocus, r"
#                  "SUPER, up, movefocus, u"
#                  "SUPER, down, movefocus, d"
#
#                  "SUPER SHIFT, left, movewindow, l"
#                  "SUPER SHIFT, right, movewindow, r"
#                  "SUPER SHIFT, up, movewindow, u"
#                  "SUPER SHIFT, down, movewindow, d"
#
#                  "SUPER ALT, left, exec, hyprctl dispatch workspace -1"
#                  "SUPER ALT, right, exec, hyprctl dispatch workspace +1"
#                  "SUPER SHIFT ALT, left, exec, hyprctl dispatch movetoworkspace -1"
#                  "SUPER SHIFT ALT, right, exec, hyprctl dispatch movetoworkspace +1"
#
#                  # switch workspaces with mod  + [0-9]
#                  "SUPER, 1, workspace, 1"
#                  "SUPER, 2, workspace, 2"
#                  "SUPER, 3, workspace, 3"
#                  "SUPER, 4, workspace, 4"
#                  "SUPER, 5, workspace, 5"
#                  "SUPER, 6, workspace, 6"
#                  "SUPER, 7, workspace, 7"
#                  "SUPER, 8, workspace, 8"
#                  "SUPER, 9, workspace, 9"
#                  "SUPER, 0, workspace, 10"
#                  "SUPER, S, togglespecialworkspace"
#
#                  # move active window to a workspace with mod + SHIFT + [0-9]
#                  "SUPER SHIFT, 1, movetoworkspace, 1"
#                  "SUPER SHIFT, 2, movetoworkspace, 2"
#                  "SUPER SHIFT, 3, movetoworkspace, 3"
#                  "SUPER SHIFT, 4, movetoworkspace, 4"
#                  "SUPER SHIFT, 5, movetoworkspace, 5"
#                  "SUPER SHIFT, 6, movetoworkspace, 6"
#                  "SUPER SHIFT, 7, movetoworkspace, 7"
#                  "SUPER SHIFT, 9, movetoworkspace, 9"
#                  "SUPER SHIFT, 0, movetoworkspace, 10"
#                  "SUPER SHIFT, S, movetoworkspace, special"
#
#                  # scroll through workspace with mouse
#                  "SUPER, mouse_down, workspace, m-1"
#                  "SUPER, mouse_up, workspace, m+1"
#
#                  # media binds
#                  ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+ --limit 1.0"
#                  ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
#
#                  ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
#                  ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
#
#                  ", XF86AudioPlay, exec, playerctl play-pause"
#                  ", XF86AudioNext, exec, playerctl next"
#                  ", XF86AudioPrev, exec, playerctl previous"
#
#                  # wayland bind passthrough
#                  "ALT,Z,pass,^(com.obsproject.Studio)$"
#              ];
#
#              bindm = [
#                  # Move/resize windows with mainMod + LMB/RMB and dragging
#                  "SUPER, mouse:272, movewindow"
#                  "SUPER, mouse:273, resizewindow"
#              ];
#
#              layerrule = [
#                  "blur,gtk-layer-shell"
#                  "ignorezero,gtk-layer-shell"
#
#                  "noanim,anyrun"
#                  "blur,anyrun"
#                  "ignorezero,anyrun"
#
#                  "blur,notifications"
#                  "ignorezero,notifications"
#              ];
#          };
     };

#     xdg.desktopPortals = {
#          enable = true;
#          portals = let useIn = [ "Hyprland" ];
#          in [
#              { package = pkgs.xdg-desktop-portal-hyprland; }
#              {
#                  package = pkgs.libsForQt5.xdg-desktop-portal-kde;
#                  interfaces = [
#                  # "org.freedesktop.impl.portal.Access"
#                  # "org.freedesktop.impl.portal.Account"
#                  # "org.freedesktop.impl.portal.AppChooser"
#                  # "org.freedesktop.impl.portal.Background"
#                  # "org.freedesktop.impl.portal.Email"
#                  "org.freedesktop.impl.portal.FileChooser"
#                  # "org.freedesktop.impl.portal.Inhibit"
#                  # "org.freedesktop.impl.portal.Notification"
#                  # "org.freedesktop.impl.portal.Print"
#                  # "org.freedesktop.impl.portal.ScreenCast"
#                  # "org.freedesktop.impl.portal.Screenshot"
#                  # "org.freedesktop.impl.portal.RemoteDesktop"
#                  # "org.freedesktop.impl.portal.Settings"
#                  ];
#                  inherit useIn;
#              }
#          ];
#      };
}
