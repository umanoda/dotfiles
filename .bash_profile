# Completions
COMPLETION=/usr/local/etc/bash_completion.d
for filename in $(ls $COMPLETION)
do
  source $COMPLETION/$filename
done

# Prompt
export PS1='\[\e[36m\]\W\[\033[33m\]$(__git_ps1 " %s")\[\033[00m\]$ '

# Alias
alias ls='ls -G'
alias ghqcd='cd $(ghq list -p | peco)'
alias be='bundle exec'
alias vscode='open -a /Applications/Visual\ Studio\ Code.app'

git-branch-cleanup() {
  git branch | egrep -v '(master$|^\*)' | xargs git branch -D
  git fetch --prune
}

# Ctrl-r にpecoを使ったHistory検索を割り当てる
peco-select-history() {
  local l=$(history | gawk '{$1 = ""; print}' | tail -r | peco)
  READLINE_LINE="${l}"
  READLINE_POINT=${#l}
}
bind -x '"\C-r": peco-select-history'

# agで検索した結果から選択し、ファイルを開く
function agvi(){
  path=$(ag $* | peco | awk -F: '{printf  $1 " +" $2}'| sed -e 's/\+$//')
  if [ -n "$path" ]; then
    echo "vim $path"
    vim $path
fi
}

# cd to git repo top dir
function u() {
  local top_git_dir=$(git rev-parse --show-superproject-working-tree --show-toplevel)
  if [ $! -eq 0 ]; then
    cd $top_git_dir
  fi
}

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
