autoload -U compinit; compinit

_comp_options+=(globdots) # With hidden files
source ~/.config/zsh/plugins/completion.zsh

fpath=(~/.config/zsh/prompt/ $fpath)
autoload -Uz purification; purification

# Alias
source ~/.config/zsh/aliases

# Directory Stack

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# VI Mode

bindkey -v
export KEYTIMEOUT=1

source ~/.config/zsh/plugins/vim_cursor

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-histor

## VI Text OBjects

autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done


# zsh-completion

fpath=(~/.config/zsh/plugins/zsh-completions/src $fpath)

# Syntax Highlighting

source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


source ~/.config/zsh/plugins/zsh-bat/zsh-bat.plugin.zsh


