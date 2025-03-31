function examples
    if test (count $argv) -eq 0
        echo "Usage: cheat <command>" | bat --paging=never
        return 1
    end
    curl -s "https://cheat.sh/$argv?T" | bat --language=sh --paging=always
end
