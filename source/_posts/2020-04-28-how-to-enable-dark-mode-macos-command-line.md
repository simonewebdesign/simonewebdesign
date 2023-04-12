---
layout: post
title: How to enable Dark Mode on macOS with the command line
description: "The easiest way, it works right away: no need to restart or install anything."
date: 2020-04-28
categories:
  - Bash
---

If you want to toggle between light and dark mode, it can be done with a single shell command:

```applescript
osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
```

Try it and it will switch the mode immediately. No need to restart or install anything.

<!--more-->

## How does it work?

It's <a href="https://en.wikipedia.org/wiki/AppleScript" rel="external">AppleScript</a>. `dark mode` is a boolean value in the user defaults system. `not dark mode` is the opposite of that value. So, for example, if the value is `true`, it's like saying `not true` (i.e. `false`), effectively acting like a light switch.

Enjoy the dark!
