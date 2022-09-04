#!/bin/zsh

# https://www.zsh.org/mla/users/2009/msg00498.html
## colorize std_err
zmodload zsh/terminfo
autoload colors is-at-least
if [[ "${terminfo[colors]}" -ge 8 ]] { colors }
color_err () {
    while read -r std_err_color
    do
      stderr_in_color=$(echo -n ${std_err_color} | sed -e "s/\(error\)/${fg_bold[red]}\1${terminfo[sgr0]}/gi" -e "s/\(warning\)/${fg_bold[yellow]}\1${terminfo[sgr0]}/gi")
      print -- "${stderr_in_color}" >&2
    done
}
## i'm not sure exactly how far back it's safe to go with this
## 4.3.4 works; 4.2.1 hangs.
is-at-least 4.3.4 && exec 2> >( color_err )
