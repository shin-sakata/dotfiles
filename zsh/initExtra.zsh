# niv で private repository を利用するのに必要
# https://github.com/nmattia/niv#2-use-the-netrc-file
export GITHUB_TOKEN=$(gh auth token)

print_directory_structure() {
    local dir=$1
    local prefix=$2
    setopt nullglob # 空のglobを無視する設定

    # ディレクトリ自体を出力（ルートディレクトリの場合は除く）
    if [ "$dir" != "." ]; then
        echo "${prefix}${dir##*/}/"
    fi

    # ディレクトリ内の各エントリに対して
    for entry in "$dir"/* "$dir"/.[!.]*(D) "$dir"/..?*(D); do
        if [[ $entry == "$dir/." || $entry == "$dir/.." || $entry == "$dir/.git" ]]; then
            continue # 特定のドットファイル/ディレクトリを無視
        fi
        if [ -d "$entry" ]; then
            # エントリがディレクトリの場合、再帰的にこの関数を呼び出す
            print_directory_structure "$entry" "  $prefix"
        else
            # エントリがファイルの場合、ファイル名をインデントして出力
            echo "  $prefix${entry##*/}"
        fi
    done
}

print_file_contents() {
    local dir="$1"
    local find_options=(-type f ! -path '*/.*') # ドットファイル/ディレクトリを除外

    if [ "$include_dotfiles" -eq 1 ]; then
        find_options=(-type f) # ドットファイルを含む
    fi

    for file in $(find "$dir" "${find_options[@]}"); do
        echo "## $file"
        cat "$file"
        echo
    done
}

ctx() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <directory>"
        return 1
    fi

    target_dir="$1"

    echo "# ディレクトリ構造" > .ctx
    print_directory_structure "$target_dir" "/" >> .ctx
    echo >> .ctx

    echo "# ファイル内容" >> .ctx
    print_file_contents "$target_dir" >> .ctx
}
