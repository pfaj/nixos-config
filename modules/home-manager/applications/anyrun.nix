{ pkgs, inputs, ... }:
{
    imports = [
        inputs.anyrun.homeManagerModules.default
    ];

    programs.anyrun = {
        enable = true;
        config = {
            plugins = with inputs.anyrun.packages.${pkgs.system}; [
                # An array of all the plugins you want, which either can be paths to the .so files, or their packages
                applications
                #dictionary
                #kidex
                #randr
                rink # math plugin
                #shell
                #stdin
                #symbols
                #translate
            ];
            width = { fraction = 0.3; };
            #position = "top";
            #verticalOffset = { absolute = 0; };
            hideIcons = false;
            ignoreExclusiveZones = false;
            layer = "overlay";
            hidePluginInfo = false;
            closeOnClick = true;
            showResultsImmediately = false;
            maxEntries = null;
        };

        extraCss = ''
            * {
                all: unset;
            }

            #window {
                background: none;
            }

            box#main {
                background: rgba(0, 0, 0, 0.5);
                border-radius: 8px;
                padding: 4px;
            }

            list#main {
                background: none;
                border-radius: 8px;
                /* padding: 8px; */
            }

            box#match {
                background: rgba(255, 255, 255, 0.075);
                border-radius: 8px;
                padding: 4px;
            }

            #entry {
                background: rgba(255, 255, 255, 0.075);
                border: 2px solid #8549a7;
                border-radius: 8px;
                padding: 8px;
            }


            list row {
                background: none;
                border-radius: 8px;
            }

            list row:hover#match {
                background: rgba(255, 255, 255, 0.125);
            }

            list row:selected#match {
                background: rgba(255, 255, 255, 0.125);
            }
        '';
    };
}
