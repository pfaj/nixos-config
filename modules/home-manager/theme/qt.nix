{ pkgs, ... }:
{
    home = {
        sessionVariables = {
            QT_STYLE_OVERRIDE = "kvantum";
        };

        packages = with pkgs; [
            libsForQt5.qtstyleplugin-kvantum
            catppuccin-kvantum
        ];
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        "%General".Theme = "Catppuccin";
    };
}
