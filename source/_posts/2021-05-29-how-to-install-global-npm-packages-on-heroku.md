---
layout: post
title: How to Install Global npm Packages on Heroku
description:
date: 2021-05-29
comments: true
---

If you need to install an [npm] package _globally_, rather than _locally_, but don't know how to do this on [Heroku], you can follow this how-to guide.

<!--more-->

Before we start, a quick word of warning: it's generally considered good practice to install your npm dependencies in the local `node_modules` folder, whenever possible. This means simply running `npm install` without the `--global` (`-g`) flag. However, sometimes this is not an option, for instance if you have a library or tool that expects a binary to be already present in the system, like in my case.

# The problem

Essentially, I had one problem: **a Ruby gem that needed a Node.js package** to be installed **globally**.

I had a [Jekyll] blog use [Pug] (Jade) for templating. Making Pug work locally was very easy using [Jekyll-Pug], a Jekyll plugin that enables Pug templates. However, when deploying on [Heroku], the build would fail because of the missing Pug library.

The [Jekyll-Pug] README is pretty clear:

> **Note:** you must have pug installed. To install it, simply enter the terminal command, `npm install pug -g`.

Two issues here:

1. I was using [Heroku's Ruby Buildpack](https://github.com/heroku/heroku-buildpack-ruby), but I also needed Node.js to be able to run `npm`;
2. I wasn't sure how to declare the global Node.js dependency.

# The solution

Point #1 was pretty straightforward: I simply needed to add the [Heroku Buildpack for Node.js](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-nodejs) alongside the Ruby one, essentially [using two buildpacks instead of one](https://devcenter.heroku.com/articles/using-multiple-buildpacks-for-an-app). You can do this by running:

```
heroku buildpacks:add --index 1 heroku/nodejs
```

This will insert the Node.js buildpack *before* Ruby, so it will be executed first.

Point #2 was about installing Pug globally. The way I went to achieve this was by using package.json's [scripts]. This is what my package.json looked like:

```json
{
  "scripts": {
    "build": "npm install pug --global"
  }
}
```

The `npm install pug --global` command would run on Heroku when pushing and, thanks to the [multi-buildpack behaviour](https://devcenter.heroku.com/articles/nodejs-support#multi-buildpack-behavior), all Node.js-related binaries would be available in subsequent buildpacks as well.

So in my specific case, this meant that Jekyll could find the global Pug binary and compile the blog successfully. Problem solved!

# Conclusion

Whilst global dependencies are to avoid whenever possible, Heroku lets us run arbitrary commands and generate any build artifacts needed for our apps to function correctly. [Buildpacks](https://devcenter.heroku.com/articles/buildpacks) are Heroku's way of handling dependencies and compile code. They have a [list of official buildpacks](https://devcenter.heroku.com/articles/buildpacks#officially-supported-buildpacks) for us to use, for free — and if you ever need to install a global dependency (or run any arbitrary command in Node.js, for that matter), you can do so using [scripts] in your package.json.

[npm]: https://www.npmjs.com/
[Heroku]: https://www.heroku.com/
[Jekyll]: https://jekyllrb.com/
[Pug]: https://pugjs.org/
[Jekyll-Pug]: https://github.com/DougBeney/jekyll-pug
[scripts]: https://docs.npmjs.com/cli/v7/using-npm/scripts