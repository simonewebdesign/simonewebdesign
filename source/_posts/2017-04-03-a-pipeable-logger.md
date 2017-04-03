---
layout: post
title: A Pipeable Logger
date: 2017-04-03
comments: true
categories: css
---

The Elixir Logger is pretty good. You can easily log anything with it, just call one of `debug`, `info`, `warn` or `error`. For example:

```elixir
Logger.info("something happened")
```

Turns into:

    12:34:56.789 [info]  something happened

Very nice. However, there are cases where you may want to, say, change some data structure, like update a map or a list, and then log the transition. Example:

```elixir
def my_function do
  list = [1, 2, 3]

  list
  |> Logger.debug("before insert: #{inspect list}")
  |> Enum.into([0])
  |> Logger.debug("after insert: #{inspect list}")
end
```

This doesn't work for many reasons. First, we can't refer to `list` that way. If we do, we will always be logging `[1, 2, 3]`, because Elixir's data structures are immutable.
Second, `Logger.*` functions return the `:ok` atom, which means you can't use them in a pipe—unless that is what you want to return.

The solution to both issues is actually pretty straightforward: use a lambda!
A lambda is just an anonymous function. We can define it and call it right away. So the code above becomes:

```elixir
def my_function do
  [1, 2, 3]
  |> (fn list ->
    Logger.debug("before insert: #{inspect list}")
    list
  end).()
  |> Enum.into([0])
  |> (fn list ->
    Logger.debug("after insert: #{inspect list}")
    list
  end).()
end
```

If we call this function, we get:

    12:34:56.789 [debug] before insert: [1, 2, 3]

    12:34:56.823 [debug] after insert: [0, 1, 2, 3]

Great, exactly what we want! Except the syntax is horrible. But fear not, we can improve on it. How about we make a wrapper?

```elixir
defmodule PipeableLogger do
  require Logger

  def debug(data, msg) do
    Logger.debug(msg)
    data
  end

  # def warn, do: ...
  # def error, do: ...
  # def info, do: ...

end
```

Let's rewrite our function once again:

```elixir
def my_function do
  [1, 2, 3]
  |> (&PipeableLogger.debug(&1, "before insert: #{inspect &1}")).()
  |> Enum.into([0])
  |> (&PipeableLogger.debug(&1, "after insert: #{inspect &1}")).()
end
```

Still not pretty though, as we still needed to wrap the function in a lambda. If we want to build a proper `Logger` wrapper, there are at least two different cases we may want to handle:

1. Logging a simple message (without any data);
2. Logging the data we receive from the pipe, maybe also with a message.

Here's the improved version of `PipeableLogger`:

```elixir
defmodule PipeableLogger do
  require Logger

  def debug(data, msg \\ "", metadata \\ [])
  def debug(data, msg, metadata) when msg == "", do: Logger.debug(data, metadata)
  def debug(data, msg, metadata) do
    Logger.debug(msg, metadata)
    data
  end

  # def warn, do: ...
  # def error, do: ...
  # def info, do: ...

end
```

Let's use it:

```elixir
def my_function do
  [1, 2, 3]
  |> PipeableLogger.debug("before insert")
  |> Enum.into([0])
  |> PipeableLogger.debug("after insert")
end
```

Much, much simpler! The only problem now is, we're logging just a message. What if we want to log the data? It's a lambda all over again.

Here's the final version I came up with:

```elixir
defmodule PipeableLogger do
  require Logger

  def debug(data, msg \\ "", metadata \\ [])
  def debug(data, msg, metadata) when msg == "", do: Logger.debug(data, metadata)
  def debug(data, msg, metadata) when is_binary(data) do
    Logger.debug(msg <> data, metadata)
    data
  end
  def debug(data, msg, metadata) do
    Logger.debug(msg <> inspect(data), metadata)
    data
  end

  # def warn, do: ...
  # def error, do: ...
  # def info, do: ...

end
```

The assumption is that we always want to concatenate the data with the message, which is fair enough I think. Let's see it in action:

```elixir
def my_function do
  [1, 2, 3]
  |> PipeableLogger.debug("before insert: ")
  |> Enum.into([0])
  |> PipeableLogger.debug("after insert: ")
end
```

```elixir
iex> my_function()

12:34:56.789 [debug] before insert: [1, 2, 3]

12:34:56.789 [debug] after insert: [0, 1, 2, 3]
[0, 1, 2, 3]
```

Now we can log the data with a message, all in a pipe and without a lambda! Nice!

---

Summing up, I'm not convinced a `Logger` wrapper is the right way. This kinda goes against the blog post, but to be fair I think Elixir people tend to use pipes way too much (I'm guilty as well). So I wouldn't probably wrap `Logger` in any project.

It's also worth noting that `Logger` supports the concept of metadata, which basically means you can already attach any data you want. For example, if you put this in your `config.exs`:

```
config :logger, :console,
  metadata: [:my_list]
```

You can then call `Logger` like this:

```
iex(1)> require Logger
Logger

iex(2)> Logger.info "Work done", my_list: inspect [1, 2, 3]

12:34:56.789 my_list=[1, 2, 3] [info]  Work done
:ok
```

Point is, you don't need a wrapper if all you want is concatenate some data in the log message. You *do* need a wrapper though (or a lambda) if you want to use `Logger` in a pipe.

So how about this instead?

```elixir
def my_function do
  list = [1, 2, 3]
  Logger.debug("before insert: #{inspect list}")
  new_list = Enum.into(list, [0])
  Logger.debug("after insert: #{inspect new_list}")
end
```

**Simple is better**. It's fine to break that pipe every once in a while!
