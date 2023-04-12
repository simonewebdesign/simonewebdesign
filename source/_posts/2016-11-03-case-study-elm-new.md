---
layout: post
title: "Case study: elm new"
date: 2016-11-03 13:00:00 +0000
categories:
  - Elm
published: false
---

`elm-new` is a command-line tool that automatically creates a new Elm project for you.

There are many tools that do exactly this. Some people may call them "code generators", or "initializers", or whatever. All they really do is just **set up some boilerplate to get you started**.

Every language ecosystem has its own. For example, Clojure developers have `lein new`. Haskellers have `cabal init`. Rustaceans have `cabal new`. You get the idea.

This is all fine and dandy, but **how do all these tools compare to each other**? For example, what if you run `lein new` without giving a project name? What if the project already exists? Should we use `init`, or `new`, or something else? Let's answer all these questions.

| | `lein` | `cargo` | `mix` | `rails` | `git` | `cabal` | `elm` |
| | ------ | ------- | ----- | ------- | ----- | ------- | ----- |
| `init` or `new`?                     | new | both | new | new | init | init | new |
| Works without project name?          |     | ✔    |     |     | ✔    | ✔    | ✔   |
| Warns on existing directory?         | ✔   | ✔    | ✔   | ✔   | ✔    | ✔    |     |
| Prompts to overwrite existing files? | ✔   |      | ✔   | ✔   |      |      |     |
| Can manage multiple versions?        |     |      |     |     |      |      |     |

## Findings

Something I found interesting was, **none of these tools are managing multiple versions**. If there is a new version of the language/framework that is totally different from the previous one (Elm, I'm looking at you!), there is no easy way to provide a different template depending on the version. Should we provide it from the CLI? Probably not. Maybe something like `elm new my-project -v 0.18` makes sense, however I don't think it's worth it. The default template should always be compatible with the latest version. If one needs a previous version, he can always download an older version of `elm-new`.

### `init` or `new`?

I found some consistent behaviour here: the tools using `init` always require the user to be in the project folder. On the other hand, `new` always requires a path/project name to be specified. `elm-new` is the black sheep here, as it works both ways. Maybe I should change that. Maybe not. What do you think?

#### Examples (no arg)

    $ lein new


    $ cargo new


    $ mix new
    ** (Mix) Expected PATH to be given, please use "mix new PATH"

    $ rails new
    No value provided for required arguments 'app_path'

    $ elm new
    .
    ├── .gitignore
    ├── README.md
    ├── elm-package.json
    └── src
        └── Main.elm

    1 directory, 4 files

    Your Elm program has been created successfully.
    You can use "elm-make" to compile it:

        elm-make src/Main.elm

    Run "elm" for more commands.


### Overwriting files

Every tool should at least warn you if the project is already present. If it doesn't, and your project is not source-controlled, you may lose important things. All tools I tried warn you if you try to overwrite an existing project.

#### Examples

    $ lein new my-project


    $ cargo new my-project


    $ mix new my-project
    ** (Mix) Expected PATH to be given, please use "mix new PATH"

    $ rails new my-project
    No value provided for required arguments 'app_path'

    $ elm new


### Should it prompt to overwrite?

Yes, I think it would be useful. All tools do it, apart from `cargo` that just warns you. But that's totally fine too.

## Conclusion

`elm-new` is still a young tool and it would be great if one day it could become part of the Elm platform. However, lots of improvements are still to be made, so it will need some more love from the Elm community.

Thanks for reading. If you want to contribute to the project in any way, feel free to do so. Any feedback is welcome, you can open new issues on the [GitHub page](https://github.com/simonewebdesign/elm-new) or just comment below.
