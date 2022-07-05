#######################################
##### Aliases + Custom Functions  #####
#######################################
alias l='ls -lt'
alias la='ls -lta'
weather() {
  # Handle our variables
  # If no arg is given, default to San Francisco
  local request curlArgs
  curlArgs="-H \"Accept-Language: ${LANG%_*}\" --compressed -m 10"
  case "${1}" in
    (-h|--help) request="wttr.in/:help" ;;
    (*)         request="wttr.in/${*:-SanFrancisco}?u" ;;
  esac

  # Finally, make the request
  curl "${curlArgs}" "${request}" 2>/dev/null \
    || printf '%s\n' "[ERROR] weather: Could not connect to weather service."
}

##################
##### Prompt #####
##################

function git_branch_name()
{
        branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
        if [[ $branch == "" ]];
        then
                :
        else
                echo '%F{red}('$branch')'
        fi
}
setopt prompt_subst
precmd () { print -rP "%B%F{yellow}%t %F{white}wetrill%b | %F{cyan}%~ $(git_branch_name)" }
PROMPT='| => '
