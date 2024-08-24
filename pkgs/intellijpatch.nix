{writeScriptBin}:
writeScriptBin "intellijpatch" ''
  rm ~/.config/JetBrains/IntelliJIdea2024.1/idea.key
''
#this is to bypass the trial limit for intellij
