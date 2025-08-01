{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    audacity
    discord
    nodejs
    obs-studio
    vlc
    ferdium
    bitwarden
    onlyoffice-bin
    pkgs.gnome-disk-utility
    vscode
    deluge
    gscreenshot
    github-desktop
    gitkraken
    #warp-terminal
    protonvpn-gui
    expressvpn
    direnv
    podman-desktop
    orca-slicer
    obsidian
    #ventoy
    rpi-imager
    ledger-live-desktop
    #logseq
    writedisk
    kdePackages.gwenview
    remmina
    teamviewer
    lmstudio
    ollama
    mission-center
    anki
    affine
    xivlauncher
    notion-app-enhanced
    heroic-unwrapped
    lima
    winbox4
    krusader
  ];
}
