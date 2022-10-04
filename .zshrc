# Prompt
export PROMPT="%F{green}%n%f %F{cyan}%1~%f %# "

source ~/.zsh/git-prompt.sh

# autocomplete
fpath=(~/.zsh $fpath)

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# aliases
alias vi=nvim

. "$HOME/.cargo/env"

# History
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection


# utilities

ghqcd() {
  local root=$(ghq root)
  local path=$(ghq list | peco)
  if [[ $path != "" ]]; then
    cd "$root/$path"
  fi
}

# cd to git repo top dir
function u() {
  local top_git_dir=$(git rev-parse --show-superproject-working-tree --show-toplevel)
  if [ $! -eq 0 ]; then
    cd $top_git_dir
  fi
}
