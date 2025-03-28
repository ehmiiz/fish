function days-until
    set target_date $argv[1]
    set now (date +%s)
    set then (date -d $target_date +%s)
    math "($then - $now) / 86400" | string split -f1 '.'
end
