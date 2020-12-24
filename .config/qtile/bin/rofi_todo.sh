#!/bin/bash

TODO_FILE=~/.rofi_todos

if [[ ! -a "${TODO_FILE}" ]]; then
    touch "${TODO_FILE}"
fi

function list_todos()
{
    TODO=$(cat "${TODO_FILE}")
    if [[ -z "${TODO}" ]]; then
        TODDO="\n"
    fi
    echo "${TODO}"
}

if [ -z "$@" ]
then
    list_todos
else
    TODO=$(echo "${@}" | sed "s/\([^a-zA-Z0-9]\)/\\\\\\1/g")
    TODO_UNSCAPED=${@}

    MATCHING=$(grep "^${TODO}$" "${TODO_FILE}")
    if [[ -n "${MATCHING}" ]]; then
        sed -i "/^${TODO}$/d" "${TODO_FILE}"
    else
        echo -e "${TODO_UNSCAPED}" >> "${TODO_FILE}"
    fi
    list_todos
fi
