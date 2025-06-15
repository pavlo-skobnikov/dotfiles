function fzf-cd-backward-widget \
    -d "Like fzf-cd-widget but allows fuzzy cd-ing backwards up the path 'till $HOME"
    set -l current_path (pwd)
    set -a path_array
    set -l parent_path (dirname $current_path)

    while test "$parent_path" != $HOME
        set -a path_array $parent_path

        set parent_path (dirname $parent_path)
    end

    set -l selected_path (printf "%s\n" $path_array | fzf)

    if test -n "$selected_path"
        cd $selected_path

        commandline -f repaint
    end
end
