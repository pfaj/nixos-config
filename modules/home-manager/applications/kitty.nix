{ ... }:
{
    programs.kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = true;
        settings = {
            scrollback_lines = 10000;
            enable_audio_bell = false;
            update_check_interval = 0;
            window_padding_width = 4;
        };
        font = {
            name = "Roboto Mono";
            size = 11;
        };
        extraConfig = ''
            background_opacity 0.85
            background_blur 0
        '';
    };
}
