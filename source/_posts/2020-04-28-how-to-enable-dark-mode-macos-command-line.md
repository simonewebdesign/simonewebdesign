---
layout: post
title: How to enable Dark Mode on macOS with the command line
date: 2020-04-28
comments: true
categories:
  - bash
  - script
  - shell
---

If you want to toggle between light and dark mode, it can be done with a single shell command:

```bash
osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
```

Try it and it will switch the mode immediately. No need to restart or install anything.

## How does it work?

It's <a href="https://en.wikipedia.org/wiki/AppleScript" rel="external nofollow">AppleScript</a>. `dark mode` is a boolean value in the user defaults system. `not dark mode` is the opposite of that value. So, for example, if the value is `true`, it's like saying `not true` (i.e. `false`), effectively acting like a light switch.

Enjoy the dark!


<!--
Dark Mode is the latest design trend: everyone seems to be adopting it. Some say it reduces eye strain, others simply want to save some battery life. Some love it, others don't. It's very popular right now, whether you like it or not.

I recently thought about jumping on the bandwagon too, by implementing a dark mode for my own website. However, it has proven more challenging than I thought.

```bash
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
```

`dark mode` is the name of a boolean variable. `not dark mode` is its opposite. In other words, the command above flips the value of dark mode between `true` and `false`.
 -->

