autoload -U compinit; compinit

_comp_options+=(globdots) # With hidden files
source ~/.config/zsh/plugins/completion.zsh

fpath=(~/.config/zsh/prompt/ $fpath)
autoload -Uz purification; purification

# Alias
source $ZDOTDIR/aliases

# Directory Stack

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# VI Mode

source $ZDOTDIR/plugins/zsh-vi-mode.plugin.zsh

# zsh-completion

fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

# Syntax Highlighting

source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-bat/zsh-bat.plugin.zsh

# History
HISTFILE=$ZDOTDIR/
HISTSIZE=10000
SAVEHIST=10000

