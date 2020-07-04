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
    curl "$host/$1" --silent -i
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

test games/pong 301
test games/pong/ "Pong"
test games/pong/js/main.js "The main game loop"

test games/game-of-life 301
test games/game-of-life/ "The Game of Life"
test games/game-of-life/style.css "background:#000;"
test games/game-of-life/game.js "THE GAME OF LIFE"

# Articles
test pure-css-onclick-context-menu 301
test pure-css-onclick-context-menu/ "A pure CSS onclick context menu"
test how-to-put-online-your-wampserver 301
test how-to-put-online-your-wampserver/ "How to put online your WampServer"

# Categories
test categories/css/ "Category: Css"
test categories/javascript 301
test categories/javascript/ "Category: Javascript"

# RSS
test rss 301
test rss/ 301
test atom.xml '<feed xmlns="http://www.w3.org/2005/Atom">'

# Sitemap
test sitemap.xml 'xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"'

# Subscribe
test 'unsub?email=test@example' "You have been unsubscribed successfully."

# Old redirects from /blog
# The actual redirect from /blog to / happens on Cloudflare so it's fine not to test it here.

# This one tests the "redirect to slash" works correctly also for old /blog links.
# Unfortunately I have to disable it because it doesn't work consistently between localhost and prod.
# (again because the redirect happens at cloudflare level. But it's fine in prod, and not important anyway.)
# test blog/playing-around-with-javascript "/blog/playing-around-with-javascript/"

exit $exit_status