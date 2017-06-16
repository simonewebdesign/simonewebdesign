# simonewebdesign

A blog powered by Octopress.

## What is Octopress?

Octopress is [Jekyll](https://github.com/mojombo/jekyll) blogging at its finest.

1. **Octopress sports a clean responsive theme** written in semantic HTML5, focused on readability and friendliness toward mobile devices.
2. **Code blogging is easy and beautiful.** Embed code (with [Solarized](http://ethanschoonover.com/solarized) styling) in your posts from gists, jsFiddle or from your filesystem.
3. **Third party integration is simple** with built-in support for Pinboard, Delicious, GitHub Repositories, Disqus Comments and Google Analytics.
4. **It's easy to use.** A collection of rake tasks simplifies development and makes deploying a cinch.
5. **Ships with great plug-ins** some original and others from the Jekyll community &mdash; tested and improved.


## Getting started

You need an old version of Ruby. To be precise, the one that's specified in .ruby-version.

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
3. `rake preview`

Hopefully that should be it. You should now be able to see the website on localhost:4000.

### Getting the submodules

Run: `git submodule update --init --recursive --remote`

If you already have submodules and just want to update them to the latest, remove `--init` from the above command.

By the way, remember that you set up a `prod` branch on each of these remotes. That's the branch that will ultimately be shipped to production. If you want to make changes, you should:

1. checkout master
2. make the changes
3. push the changes
4. checkout prod
5. `git rebase origin/master`

### Preparing for the first deploy

- **Ensure that you have downloaded and initialised correctly all the git modules before proceeding!**
- Install the Heroku toolbelt
- `heroku login`
- `git remote add heroku https://git.heroku.com/simo.git`
- `rake gen_deploy_heroku`


## Troubleshooting

### Website down after deploy

You have to redeploy from master.

### CSS changes work locally but not in production

It must be the cache: wipe it out from cloudflare.
