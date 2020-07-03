#!/usr/bin/env bash

host=$1

echo "Starting end-to-end test on host: $host"

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

# Home page and core assets
test "" "Simone Web Design"
test stylesheets/style.css "html{text-rendering:optimizelegibility;-moz-osx-font-smoothing:grayscale;-webkit-font-smoothing:antialiased;background:#f6f6f6 url("
test sw.js 'self.addEventListener("fetch"'

# Submodules
test hire/me/ "NOT FOUND"
test demo/elm/ "Credit Card Checkout"
test demo/html5editor/ "Hey, buddy!"

test games/pong/ "Pong"
test games/pong/js/main.js "The main game loop"

test games/game-of-life/ "The Game of Life"
test games/game-of-life/style.css "background:#000;"
test games/game-of-life/game.js "THE GAME OF LIFE"

exit $exit_status