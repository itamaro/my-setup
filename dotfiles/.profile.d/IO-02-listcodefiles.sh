SNIPPETS_DIR="$HOME/work/ostrich/snippets"

listcodefiles () {
  find . -path ./build -prune -o -path ./third_party -prune \
    -o -path ./venv -prune -o -path ./unity/search_plugin -prune \
    -o -path ./.eggs -prune -o -path ./yabtwork -prune \
    -o -path ./.make -prune -o -path ./_output -prune \
    -o -path ./.git -prune -o -path "*/node_modules" -prune -o \
    -path "*/bower_components" -prune -o -path ./viewer_extjs -prune -o -path \
    ./search_prototype/.tmp -prune -o -path ./search_prototype/.sass-cache \
    -prune -o -path ./search_prototype/dist -prune -o -path "*/icons" -prune -o \
    -path "*/test_data" -prune -o -path "*/test-data" -prune -o -path "*/fonts" \
    -prune -o -path ./alfred/ui/dist -prune -o -path ./viewer2 -prune \
    -o -path ./twotothree -prune -o \( ! -name "*.pyc" ! \
    -name "*.pyo" ! -name "*.stl" ! -name "*.ypb" ! -name "*.svg" ! -name \
    "*.3ds" ! -name "*.gif" ! -name "*.rpm" ! -name "*.ply" ! -name "*.jpg" ! -name \
    "*.zip" ! -name "*.apb" ! -name "*.ico" ! -name "*.min.js" ! -name "*.png" -type f \) $@
}

codegrep () {
    listcodefiles -exec grep --color=auto -Hn "$@" {} \;
}

alias fastcodegrep='codegrep -F'
alias recodegrep='codegrep -E'

# Grep my code snippets
snipgrep () {
    find $SNIPPETS_DIR -path "*/.git" -prune -o -type f -exec grep --color=auto -Hn "$@" {} \;
}

# Grep by bash profile stuff
profilegrep () {
    find $HOME/.profile.d/ -path "*/.git" -prune -o -type f -exec grep --color=auto -Hn "$@" {} \;
    find $HOME/.private.profile.d/ -path "*/.git" -prune -o -type f -exec grep --color=auto -Hn "$@" {} \;
}
