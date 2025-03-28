function bw-get
    ######################################################
    #  Description: Get a password from Bitwarden, copies
    # it to the clipboard and shows the items in fzf.
    #  Dependencies:
    # - bw (Bitwarden CLI)
    # - fzf (fuzzy finder)
    # - jq (JSON processor)
    # Author: Emil Larsson
    # Date: 2025-03-28
    # Check if BW_SESSION is set
    ######################################################
    if not set -q BW_SESSION
        echo "Unlocking Bitwarden vault..."
        set -gx BW_SESSION (bw unlock --raw)
    end

    # If no argument provided, show all items
    if test (count $argv) -eq 0
        set items (bw list items | jq -r '.[] | "\(.name)\t\(.login.username)\t\(.revisionDate)\t\(.id)"')
    else
        # Get item name from arguments and filter
        set name $argv[1]
        set items (bw list items | jq -r ".[] | select(.name | test(\"$name\"; \"i\")) | \"\(.name)\t\(.login.username)\t\(.revisionDate)\t\(.id)\"")
    end

    if test (count $items) -eq 0
        echo "No items found" >&2
        return 1
    end

    # If there is only one match and name was provided, get the password
    if test (count $items) -eq 1; and test (count $argv) -gt 0
        set id (echo $items[1] | cut -f4)
        bw get item $id | jq -r '.login.password' | wl-copy
        return
    end

    # Show fzf selection
    set selection (printf "%s\n" $items | fzf --delimiter=\t --with-nth=1,2,3 --header="NAME USERNAME LAST_MODIFIED" --preview-window=hidden)
    
    if test $status -eq 0
        set id (echo $selection | cut -f4)
        bw get item $id | jq -r '.login.password' | wl-copy
    end
end
