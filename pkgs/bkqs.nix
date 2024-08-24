{writeScriptBin}:
writeScriptBin "bkqs" ''
  tar --exclude=.backup --absolute-names -czf ~/.config/quickshell/.backup/backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz ~/.config/quickshell
''
