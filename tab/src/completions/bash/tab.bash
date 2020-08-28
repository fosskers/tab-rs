# `tab` autocompletions for bash

_tab() {
    local i cur prev opts cmds
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${i}" in
            tab)
                cmd="tab"
                ;;
            
            *)
                ;;
        esac
    done

    case "${cmd}" in
        tab)
            opts=" -l -W -h -V -w  --list --shutdown --help --version --_launch --close  <TAB> "
            # dynamic autocompletions
            if [[ ${cur} == "" ]]; then
                COMPREPLY=( $(tab --_autocomplete_tab) )
                return 0
            fi
            if [[ ${cur} == "-w" ]]; then
                COMPREPLY=( $(tab --_autocomplete_close_tab) )
                return 0
            fi
            if [[ ${cur} == "--close" ]]; then
                COMPREPLY=( $(tab --_autocomplete_close_tab) )
                return 0
            fi

            # autogenerated static autocompletions
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --_launch)
                    COMPREPLY=($(compgen -W "daemon pty" -- "${cur}"))
                    return 0
                    ;;
                --close)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -w)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        
    esac
}

complete -F _tab -o bashdefault -o default tab
