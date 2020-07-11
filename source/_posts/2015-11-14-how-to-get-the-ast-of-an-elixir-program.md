---
layout: post
title: "How to get the AST of an Elixir program"
date: 2015-11-14 19:43:10 +0000
comments: true
categories:
  - Elixir
---

Getting the **AST** (Abstract Syntax Tree) representation of an **Elixir** source is pretty simple.

Let's say we want to get the **AST of this file**:

``` elixir lib/hello.ex
defmodule Hello do

  def hi(name) do
    IO.puts "Hello " <> name
  end

end
```

We can do it right away from `iex`:

{% raw %}
``` elixir
$ iex
Erlang/OTP 18 [erts-7.0] [source] [64-bit] [smp:8:8] [async-threads:10] [kernel-poll:false]

Interactive Elixir (1.0.5) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> {:ok, ast} = Code.string_to_quoted(File.read!("lib/hello.ex"))
{:ok,
 {:defmodule, [line: 1],
  [{:__aliases__, [counter: 0, line: 1], [:Hello]},
   [do: {:def, [line: 3],
     [{:hi, [line: 3], [{:name, [line: 3], nil}]},
      [do: {{:., [line: 4],
         [{:__aliases__, [counter: 0, line: 4], [:IO]}, :puts]}, [line: 4],
        [{:<>, [line: 4], ["Hello ", {:name, [line: 4], nil}]}]}]]}]]}}
```
{% endraw %}

In our case, the `ast` variable will contain the full AST of the source code.

In case you want to get the **AST of a single line**, it's even simpler:

{% raw %}
``` elixir
iex(1)> name = "John"
"John"

iex(2)> IO.puts "Hello " <> name
Hello John
:ok

iex(3)> ast = quote do: IO.puts "Hello " <> name
{{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [],
 [{:<>, [context: Elixir, import: Kernel], ["Hello ", {:name, [], Elixir}]}]}
```
 {% endraw %}

For more context, I recommend reading the [introduction to meta-programming in Elixir](https://elixir-lang.org/getting-started/meta/quote-and-unquote.html) on Elixir's official site.

In case you're interested in **parsing Elixir**, [Tokenizing and parsing in Elixir with yecc and leex](https://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/) by Andrea Leopardi is a very recommended reading.

Have fun with Elixir!
