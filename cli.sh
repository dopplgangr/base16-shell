#!/bin/env bash

base16()(

  help()(
    echo "help"
  )

  loadtheme()(
    local dir=./scripts/
    source "$dir/$1"
    put_template 0  $color00
    put_template 1  $color01
    put_template 2  $color02
    put_template 3  $color03
    put_template 4  $color04
    put_template 5  $color05
    put_template 6  $color06
    put_template 7  $color07
    put_template 8  $color08
    put_template 9  $color09
    put_template 10 $color10
    put_template 11 $color11
    put_template 12 $color12
    put_template 13 $color13
    put_template 14 $color14
    put_template 15 $color15
    
    # 256 color space
    put_template 16 $color16
    put_template 17 $color17
    put_template 18 $color18
    put_template 19 $color19
    put_template 20 $color20
    put_template 21 $color21
    
    put_template_custom Pg a5a2a2 # foreground
    put_template_custom Ph 090300 # background
    put_template_custom Pi a5a2a2 # bold color
    put_template_custom Pj 4a4543 # selection color
    put_template_custom Pk a5a2a2 # selected text color
    put_template_custom Pl a5a2a2 # cursor
    put_template_custom Pm 090300 # cursor text
    put_template_var 10 $color_foreground
    put_template_var 11 $color_background
    put_template_custom 12 ";7" # cursor (reverse video)
    
    # clean up
    unset -f put_template
    unset -f put_template_var
    unset -f put_template_custom
    unset color00
    unset color01
    unset color02
    unset color03
    unset color04
    unset color05
    unset color06
    unset color07
    unset color08
    unset color09
    unset color10
    unset color11
    unset color12
    unset color13
    unset color14
    unset color15
    unset color16
    unset color17
    unset color18
    unset color19
    unset color20
    unset color21
    unset color_foreground
    unset color_background
  )

  isValidArg()(
    if [[ $SHELL =~ .*zsh ]]; then
      [[ "$(type -w "$1")" =~ ".*function" ]]
      return $?
    else
      test "$(type -t "$1")" = "function"
    fi
  )

  put_template()(
    printf '\033P\033]4;%d;rgb:%s\007\033\\' $@
  )
  
  put_template_var()(
    printf '\033P\033]%d;rgb:%s\007\033\\' $@
  )
  
  put_template_custom()(
    printf '\033P\033]%s%s\007\033\\' $@; 
  )

  if isValidArg "$1"
  then "$@"
  else help
  fi
)


