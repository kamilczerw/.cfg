local ret_status="%(?:%{$fg[green]%}$ :%{$fg[red]%}$ )"

KUBE_PS1_SEPARATOR=" "

PROMPT='%{$fg[cyan]%}%c %{$reset_color%}$(kube_ps1) ${ret_status}%{$reset_color%}'
