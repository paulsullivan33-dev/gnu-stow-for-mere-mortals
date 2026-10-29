# A small sample shell configuration.
export EDITOR=vim
export PAGER=less
PS1='[\u@\h \W]\$ '

# Extra definitions live in their own file.
if [ -f "$HOME/.config/bash/extra.sh" ]; then
    . "$HOME/.config/bash/extra.sh"
fi
