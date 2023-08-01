{}:
let usingHyprland = programs.hyprland ? enable && programs.hyprland.enable;
{
    options = mkIf usingHyprland {
        programs.hyprland.nvidiaPatches = true;

        environment.sessionVariables = {
            WLR_NO_HARDWARE_CURSORS = "1";
        };
    };
}
