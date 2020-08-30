#!/usr/bin/env bash

host=$1
exit_status=0

echo "Starting end-to-end test on host: $host"

function ok {
    echo -e ' \033[32m✓\033[0m'
}

function fail {
    echo -e ' \033[31m✗\033[0m'
    # exit_status is a counter of failures
    exit_status=$(($exit_status+1))
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
test stylesheets/about.css ".about-intro picture{float:left;"
test stylesheets/projects.css ".projects section+section{margin-top:"
test stylesheets/archives.css "#archive #content>div,#archive #content>div>article{padding-top:0}"

# Main pages
test archives/ "Blog Archives"
test projects/ "Open Source Projects"
test about/ "About Simone"
test 404/ "NOT FOUND"
test contribs/ "Notable Contributions on GitHub"
test offline/ "Oh Noes, The Internet's Gone Down!"

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
test categories/css/ "Articles about CSS"
test categories/git 301
test categories/git/ "Articles about Git"
test categories/javascript 301
test categories/javascript/ "Articles about JavaScript"
# test categories/gamedev/ "Articles about Gamedev" # Game Development
# test categories/inspirational/ "Articles about Inspirational"

# RSS
test rss 301
test rss/ 301
test feed/ 301
test atom.xml '<feed xmlns="http://www.w3.org/2005/Atom">'

# Sitemap
test sitemap.xml 'xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"'

# Subscribe
# without the email param it should redirect to the home page
test unsub 301
test unsub/ 301
# (disabled because it's slow)
# test 'unsub?email=test@example' "You have been unsubscribed successfully."

# Old redirects from /blog
# The actual redirect from /blog to / happens on Cloudflare so it's fine not to test it here.
# There is also the redirect from http to https happening at that lavel.

# This one tests the "redirect to slash" works correctly also for old /blog links.
# Unfortunately I have to disable it because it doesn't work consistently between localhost and prod.
# (again because the redirect happens at cloudflare level. But it's fine in prod, and not important anyway.)
# test blog/playing-around-with-javascript "/blog/playing-around-with-javascript/"

# More legacy redirects - ideally those should all redirect to the blog archives page
test posts 301
test posts/ 301
test posts/7 301
test posts/7/ 301


if [ $exit_status -eq 0 ]
then
  echo -e "\033[32mSUCCESS\033[0m"
else
  echo -e "\033[31m$exit_status FAILURE(S)\033[0m" >&2
fi

exit $exit_status