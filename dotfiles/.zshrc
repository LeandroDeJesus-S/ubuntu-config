if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(poetry zsh-autosuggestions zsh-autocomplete zsh-syntax-highlighting fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# aliases
alias tok32="python -c \"import secrets;print(secrets.token_hex(32))\""
alias tok64="python -c \"import secrets;print(secrets.token_hex(64))\""
alias c='f() { echo "scale=4; $*" | bc -l; }; f'
alias poff="shutdown -P +0"
alias cvim='nvim --clean --cmd "set clipboard=unnamedplus" $*'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export LD_LIBRARY_PATH=$HOME/opt/lib:$LD_LIBRARY_PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

kitty_upinstall(){
    if ! command -v kitty; then
        echo "installing kitty"
    else
	echo "updating kitty"
    fi
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
}
