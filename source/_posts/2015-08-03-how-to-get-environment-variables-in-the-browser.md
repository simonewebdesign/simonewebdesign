---
layout: post
title: "How To Get Environment Variables in the Browser"
date: 2015-08-03 12:00:00 +0100
comments: true
categories:
- Bash
- JavaScript
---

## Preface: Why?

**Environment variables** are very useful for **configuring your app** depending on the environment, without having to hardcode any value in the source.

At my current company we are building a **microservice infrastructure**, where the **frontend** and the **backend** are completely decoupled applications. We also use [Docker](https://docker.com/) to manage these microservices and link them together. Turns out that storing the configuration in the environment—as opposed to storing it in the database or in the code itself—is quite valuable, as described also in the [twelve-factor](http://12factor.net/config) methodology.

### Advantages:

- Language and OS agnostic;
- Easy to change between deploys without changing any code;
- Impossible to accidentally check in source control.

## How?

A web page doesn't have access to OS variables, so you can't normally use them.

The solution is pretty simple: you just need to **generate a file that contains them**.

For such a trivial task you could be tempted to use your language of choice, e.g. in JavaScript (Node.js) you have access to `process.env.SOME_VAR`. In Python you would probably do `os.getenv('SOME_VAR')` and in Ruby you'd use `ENV['SOME_VAR']`—but what about some old-school shell scripting? The script could be as simple as:

``` bash bin/env.sh
echo "env = {"
echo "  USER: '$USER',"
echo "  HOSTNAME: '$HOSTNAME'"
echo "}"
```

That, when executed, will become:

``` javascript env.js
env = {
  USER: 'simone',
  HOSTNAME: 'ubuntu'
}
```

And the script to execute is:

``` bash
$ ./bin/env.sh > env.js
```

Pretty straightforward, isn't it?


### Test it:

{% highlight html %}
{% raw %}
<!DOCTYPE html>
<html>
<head>
  ...
</head>
<body>
  <script src="env.js"></script>
  <script>
    console.log(env.USER +'@'+ env.HOSTNAME); // "simone@ubuntu"
  </script>
</body>
</html>
{% endraw %}
{% endhighlight %}

One downside to this approach is that you have to "make a build" every time you change the variables. If you know any workarounds or better solutions, please let me know!

### Source and download

Find the source code on [GitHub](https://github.com/simonewebdesign/frontend-env-vars). Download the zip file [here](https://github.com/simonewebdesign/frontend-env-vars/archive/master.zip).

Have fun!
