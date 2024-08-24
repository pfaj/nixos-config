{writeScriptBin}:
writeScriptBin "rmshit" ''
  rm -r ~/.config/gtk* &&
  rm ~/.gtkrc-2.0 &&
  rm ~/.local/share/mimeapps.list &&
  rm ~/.config/mimeapps.list &&
  rm ~/.config/mimeapps.list.hm-backup
''
