{pkgs, ...}: {
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu-mono
  ];

  fonts.fontconfig.localConf = ''
    <match target="pattern">
      <test name="lang" compare="contains">
        <string>ja</string>
      </test>
      <test name="family">
        <string>sans-serif</string>
      </test>
      <edit name="family" mode="prepend" binding="strong">
        <string>Noto Sans CJK JP</string>
      </edit>
    </match>

    <match target="pattern">
      <test name="lang" compare="contains">
        <string>ja</string>
      </test>
      <test name="family">
        <string>serif</string>
      </test>
      <edit name="family" mode="prepend" binding="strong">
        <string>Noto Serif CJK JP</string>
      </edit>
    </match>

    <match target="pattern">
      <test name="lang" compare="contains">
        <string>ja</string>
      </test>
      <test name="family">
        <string>monospace</string>
      </test>
      <edit name="family" mode="prepend" binding="strong">
        <string>Noto Sans Mono CJK JP</string>
      </edit>
    </match>
  '';
}
