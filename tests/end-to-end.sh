#!/usr/bin/env bash

host=$1
exit_status=0

if [ $# -eq 0 ]
  then
    echo "Error: No arguments supplied. Please provide host name as the first and only argument."
    exit 1
fi

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
    if [[ "$(call $1)" =~ $2 ]]; then ok; else fail; fi
}

echo "###################"
echo "# END-TO-END TEST #"
echo "###################"
echo
echo "## Redirects"
echo
echo -n Redirects from http to https
if [[ "$(curl http://simonewebdesign.it --silent -i)" =~ https://simonewebdesign.it ]]; then ok; else fail; fi

echo -n Redirects from www to non-www
if [[ "$(curl https://www.simonewebdesign.it --silent -i)" != *"www"* ]]; then ok; else fail; fi

echo -n Redirects from http www to https non-www
if [[ "$(curl http://www.simonewebdesign.it --silent -i)" =~ https://simonewebdesign.it ]]; then ok; else fail; fi

# Legacy redirects from /blog
echo -n Redirects from /blog/:path to /:path/
if [[ "$(curl -I --silent $host/blog/foo)" != *"blog"* ]]; then ok; else fail; fi

echo -n Redirects from /blog/:path/ to /:path/ do not have an extra trailing slash
if [[ "$(curl -I --silent $host/blog/foo/)" != *"foo//"* ]]; then ok; else fail; fi

echo
echo "## Core assets"
test stylesheets/style.css "@charset "
test sw.js "self.addEventListener\('install'"
test stylesheets/about.css ".about-intro"
test stylesheets/projects.css ".projects section"
test stylesheets/archives.css ".categories-list"
test stylesheets/atom.css "feed {"

echo
echo "## Top-level pages"
test "" "Simone Web Design"
test archives/ "Blog Archives"
test projects/ "Projects"
test about/ "About Simone"
test fubar "not found"
test contribs/ "Notable Contributions on GitHub"

# Regression test: about page should not contain categories.css
# Disabled because I don't really care about testing this.
# Also nice to have as reference.
# test about/?regression "<link rel=\"stylesheet\" href=\"\/stylesheets\/about.css\" media=\"screen\">[[:space:]]*<link rel=\"alternate\""

echo
echo "## Submodule pages"
# testing for 404 instead of the string "not found" will:
# 1. diversify the tests, since we're already directly testing 404.html page to match "not found".
# 2. make the test pass both locally and in production, because locally the 404.html isn't served on a 404 error - rather, an empty body is served.
test hire/me/ 404
test demo/elm/ "Credit Card Checkout"
test demo/html5editor/ "Hey, buddy!"

# Testing redirects: Local webserver (config.ru) will return HTTP/1.1 301 Moved Permanently,
# whilst Cloudflare will return HTTP/2 308. Testing for "30" will catch both.
test games/pong " 30"
test games/pong/ "Pong"
test games/pong/js/main.js "The main game loop"

test games/game-of-life " 30"
test games/game-of-life/ "The Game of Life"
test games/game-of-life/style.css "background:#000;"
test games/game-of-life/game.js "THE GAME OF LIFE"

echo
echo "## Articles"
test pure-css-onclick-context-menu " 30"
test pure-css-onclick-context-menu/ "A pure CSS onclick context menu"
test how-to-put-online-your-wampserver " 30"
test how-to-put-online-your-wampserver/ "How to put online your WampServer"

echo
echo "## Article categories"
test categories/css/ "Articles about CSS"
test categories/git " 30"
test categories/git/ "Articles about Git"
test categories/javascript " 30"
test categories/javascript/ "Articles about JavaScript"
test categories/ruby/ "Articles about Ruby"
test categories/bash/ "Articles about Bash"
test categories/elixir/ "Articles about Elixir"
test categories/swift/ "Articles about Swift"
test categories/php/ "Articles about PHP"
test categories/elm/ "Articles about Elm"
test categories/clojure/ "Articles about Clojure"
test categories/rust/ "Articles about Rust"
# test categories/gamedev/ "Articles about Gamedev" # Game Development
# test categories/inspirational/ "Articles about Inspirational"

echo
echo "## Metadata"

# These are redirects
test rss "location: $host/atom.xml"
test rss/ "location: $host/atom.xml"
test feed/ "location: $host/atom.xml"

test atom.xml '<feed xmlns="http://www.w3.org/2005/Atom">'
test sitemap.xml 'xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"'
test public-key.asc '-----BEGIN PGP PUBLIC KEY BLOCK-----'

# Subscribe
# without the email param it should redirect to the home page
# Functionality disabled
# test unsub 301
# test unsub/ 301

# Disabled because it sends me an actual email!
# test 'unsub?email=test@example' "You have been unsubscribed successfully."

# More legacy redirects - ideally those should all redirect to the blog archives page
test blog "location: $host/archives/"
# test posts "location: $host/archives/"
# test posts/ "location: $host/archives/"
test posts/7 "location: $host/archives/"
test posts/4/ "location: $host/archives/"
# test blog/1req "location: $host/1req/" # duplicate of :path one, but needed

echo
echo "## Miscellaneous assets"
test videos/omg-cat.mp4 200


if [ $exit_status -eq 0 ]
then
  echo -e "\033[32mSUCCESS\033[0m"
else
  echo -e "\033[31m$exit_status FAILURE(S)\033[0m" >&2
fi

exit $exit_status
