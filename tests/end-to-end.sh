#!/usr/bin/env bash

host=$1

function ok {
    echo -e ' \033[32m✓\033[0m'
}

function fail {
    echo -e ' \033[31m✗\033[0m'
    exit_status=1
}

function call {
    curl "$host/$1" --silent
}

function test {
    echo -n "Test $host/$1"
    if [[ "$(call $1)" =~ "$2" ]]; then ok; else fail; fi
}

test games/pong/ "Pong"

exit $exit_status