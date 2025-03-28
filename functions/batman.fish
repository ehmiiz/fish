function batman
    man $argv | col -bx | bat -l man -p
end
