---
layout: post
title: Dark Mode
categories:
  - bash
---

Dark Mode is the latest design trend: everyone seems to be adopting it. Some say it reduces eye strain, others simply want to save some battery life. Some love it, others don't. It's very popular right now, whether you like it or not.

I recently thought about jumping on the bandwagon too, by implementing a dark mode for my own website. However, it has proven more challenging than I thought.

```bash
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
```

`dark mode` is the name of a boolean variable. `not dark mode` is its opposite. In other words, the command above flips the value of dark mode between `true` and `false`.
