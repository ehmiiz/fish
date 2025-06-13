function runfp
    # runs an installed flatpak from user selected list
    flatpak run (flatpak list --app --columns=application | fzf) > /dev/null 2>&1 &
end
