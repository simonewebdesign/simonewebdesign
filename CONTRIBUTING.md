## Getting started

### Prerequisites

Download and install:

1. `chruby`
2. `chruby-fish` (assuming you use fish shell)
3. `ruby-install`

Run: `ruby-install (cat .ruby-version)`

Wait for it to compile.

Then run:

1. `gem install bundler --no-ri --no-doc`
2. `bundle`
3. `npm install`
4. `bundle exec rake preview`

Hopefully that should be it. You should now be able to see the website on http://localhost:4000.


### Getting the submodules

Run: `git submodule update --init --recursive --remote`

If you already have submodules and just want to update them to the latest, remove `--init` from the above command.

By the way, remember that you set up a `prod` branch on each of these remotes. That's the branch that will ultimately be shipped to production. If you want to make changes, you should:

1. checkout main
2. make the changes
3. push the changes
4. checkout prod
5. `git rebase origin/main`


## Troubleshooting

### CSS changes work locally but not in production

It must be the cache: wipe it out from cloudflare.

### Pygments (code coloring) not working

You may need Python 2 instead of 3. If you have it in your $PATH, the error should go away.
See: https://philippe.bourgau.net/how-i-fixed-the-unknown-language-pygments-error-in-octopress/. In your local macbook you may have it in /usr/local/bin/python and /usr/bin/python.

### mysql2 gem not installing

`brew install mysql` first.

### libv8 gem not installing

Error:

    clang: warning: include path for libstdc++ headers not found; pass '-stdlib=libc++' on the command line to use the libc++ standard library instead [-Wstdlibcxx-not-found]
    In file included from ../src/allocation.cc:33:
    ../src/utils.h:33:10: fatal error: 'climits' file not found
    #include <climits>
            ^~~~~~~~~
    1 error generated.

Fix:

    env \
    CXX=clang++ \
    GYPFLAGS=-Dmac_deployment_target=10.9 \
    gem install libv8 --version 3.16.14.19

## Inline-scripts is returning ENOENT error

Open node_modules/inline-scripts/src/inlineStylesheets.js and patch this line:

```diff
- path.resolve(path.dirname(htmlPath), relPath);
+ path.resolve('public', relPath);
```
