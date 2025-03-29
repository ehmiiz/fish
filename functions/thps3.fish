function thps3
    set GAME_ISO "$HOME/Games/PS2/thps3.iso"
    set GAME_ISO (realpath -e "$GAME_ISO")
    flatpak run net.pcsx2.PCSX2 "$GAME_ISO"
end
