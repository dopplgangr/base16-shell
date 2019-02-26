BASE16_SHELL=$(dirname ${(%):-%x})
[ -n "$PS1" ] && [ -s $BASE16_SHELL/cli.sh ] && source $BASE16_SHELL/cli.sh
[ -f ~/.base16_theme ] && base16 restore
