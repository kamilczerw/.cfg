local ret_status="%(?:%{$fg[green]%}$ :%{$fg[red]%}$ )"

PROMPT='%{$fg[cyan]%}%c %{$reset_color%}${ret_status}%{$reset_color%}'