#!/bin/env bash

export BASE16_SHELL

base16()(

  help()(
    echo "help"
  )

  load()(
    local dir=$BASE16_SHELL/scripts
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

  colortest()(
    ansi_mappings=(
      Black
      Red
      Green
      Yellow
      Blue
      Magenta
      Cyan
      White
      Bright_Black
      Bright_Red
      Bright_Green
      Bright_Yellow
      Bright_Blue
      Bright_Magenta
      Bright_Cyan
      Bright_White
    )
    colors=(
      base00
      base08
      base0B
      base0A
      base0D
      base0E
      base0C
      base05
      base03
      base08
      base0B
      base0A
      base0D
      base0E
      base0C
      base07
      base09
      base0F
      base01
      base02
      base04
      base06
    )
    for padded_value in `seq -w 0 21`; do
      color_variable="color${padded_value}"
      eval current_color=\$${color_variable}
      current_color=$(echo ${current_color//\//} | tr '[:lower:]' '[:upper:]') # get rid of slashes, and uppercase
      non_padded_value=$((10#$padded_value))
      base16_color_name=${colors[$non_padded_value]}
      current_color_label=${current_color:-unknown}
      ansi_label=${ansi_mappings[$non_padded_value]} 
      block=$(printf "\x1b[48;5;${non_padded_value}m___________________________")
      foreground=$(printf "\x1b[38;5;${non_padded_value}m$color_variable")
      printf "%s %s %s %-30s %s\x1b[0m\n" $foreground $base16_color_name $current_color_label ${ansi_label:-""} $block
    done;
  )

  isValidArg()(
    if [[ $SHELL =~ .*zsh ]]; then
      [[ "$(type -w "$1")" =~ ".*function" ]]
      return $?
    else
      test "$(type -t "$1")" = "function"
    fi
  )

  save()(
    cat << EOF > ~/.base16_theme
$1
EOF
  )

  restore()(
    load "$(cat ~/.base16_theme)"
  )

  put_template()(
    if [ "${TERM%%-*}" = "xterm" ]; then
      printf '\033]4;%d;rgb:%s\033\\' $@
    else
      printf '\033P\033]4;%d;rgb:%s\007\033\\' $@
    fi
  )
  
  put_template_var()(
    if [ "${TERM%%-*}" = "xterm" ]; then
      printf '\033]%d;rgb:%s\033\\' $@
    else
      printf '\033P\033]%d;rgb:%s\007\033\\' $@
    fi
  )
  
  put_template_custom()(
    if [ "${TERM%%-*}" = "xterm" ]; then
      printf '\033]%s%s\033\\' $@
    else
      printf '\033P\033]%s%s\007\033\\' $@
    fi
  )

  if isValidArg "$1"
  then "$@"
  else help
  fi
)


