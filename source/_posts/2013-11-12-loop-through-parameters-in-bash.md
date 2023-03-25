---
title: Loop through parameters in Bash
description: "Iterating over the arguments in a Bash script is simpler than you might expect: for WORD; do; echo $WORD; done"
layout: post
permalink: /loop-through-parameters-in-bash/
date: 2013-11-12
updated: 2023-03-25
comments: true
categories:
  - Bash
---

Iterating over the arguments in a Bash script is simpler than you might expect:

```bash
for WORD; do
  echo $WORD
done
```

Another way is:

```bash
for i in "$@"
do
  echo "$i"
done
```

In the snippet above, `"$@"` represents all the parameters. The `echo "$i"` prints each argument on a separate line.

It's always a good idea to wrap variables within quotes, because they could contain spaces or whatever.
