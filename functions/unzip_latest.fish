function unzip_latest
    # Local variables
    set -l zip_file (ls -t ~/Downloads/*.zip | head -n 1)
    set -l app_name (basename $zip_file .zip)
    set -l target_dir ~/Apps/$app_name
    
    # ~Apps directory
    if not test -d ~/Apps
        echo (set_color yellow)"Creating ~/Apps directory..."(set_color normal)
        mkdir -p ~/Apps
    end

    # Inform & confirm
    echo (set_color cyan)"Found zip file: "(set_color yellow)"$zip_file"(set_color normal)
    read -l -P "Verify that the file is correct [y/N] " confirm

    if test "$confirm" != "y" -a "$confirm" != "Y"
        echo (set_color red)"Halting."(set_color normal)
        return 1
    end
   
    echo (set_color cyan)"Extracting to: "(set_color yellow)"$target_dir"(set_color normal)

    if test -d $target_dir
        echo (set_color yellow)"Found existing directory: "(set_color green)"$target_dir"(set_color normal)
        echo (set_color yellow)"Removing existing directory..."(set_color normal)
        rm -rf $target_dir
    end
    echo (set_color yellow)"Creating fresh directory..."(set_color normal)
    mkdir -p $target_dir
    
    # Unzip the file into the new folder
    echo (set_color yellow)"Unzipping files to $target_dir..."(set_color normal)
    unzip -l $zip_file | tail -n +4 | head -n -2 | awk '{print $4}' | while read -l file
        echo (set_color brblue)"  Extracting: $file"(set_color normal)
    end
    unzip -q $zip_file -d $target_dir

    echo (set_color yellow)"Moving to -> "(set_color green)"$target_dir"(set_color normal)
    cd $target_dir
    pwd
    echo (set_color green)"Done!"(set_color normal)
    
end
