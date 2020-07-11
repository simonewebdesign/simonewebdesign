---
layout: post
title: Blending together two lists in Elm and Swift
date: 2016-07-03 19:30:00 +0000
comments: true
---

Here's a fun kata:

> Create a `blend` function that, given two lists of the same length, returns a new list with each element alternated. E.g.:
>
>     blend [1, 2, 3] [4, 5, 6]
>     => [1, 4, 2, 5, 3, 6]

As with all challenges, it can be solved in many different ways. However this particular one is easily solvable with functional programming techniques such as recursion.

You can try implementing it on your own first or just look straight at the solutions below.


## Solution in Elm

The one below is probably the most straightforward solution:

``` haskell
blend : List a -> List a -> List a
blend xs ys =
    case xs of
        x :: xs' -> x :: blend ys xs'
        _ -> []
```

Notice how I exchanged the arguments in the recursion call. That did the trick!

Let's try it in the REPL -- I added slashes so you can copy-paste the function:

``` haskell
$ elm-repl

> blend xs ys = \
    case xs of \
        x :: xs' -> x :: blend ys xs' \
        _ -> []

<function> : List a -> List a -> List a

> blend [0,0,0] [1,1,1]
[0,1,0,1,0,1] : List number
```


## Solution in Swift

We can achieve the same in Swift by using an extension that splits up an Array into head and tail (credits to [Chris Eidhof](http://chris.eidhof.nl/post/swift-tricks/)):

``` swift
extension Array {
    var match : (head: T, tail: [T])? {
      return (count > 0) ? (self[0],Array(self[1..<count])) : nil
    }
}
```

And here's the solution:

``` swift
func blend(firstArray: Array<AnyObject>, secondArray: Array<AnyObject>) -> Array<AnyObject> {
    if let (head, tail) = firstArray.match {
        return [head] + blend(secondArray, secondArray: tail)
    } else {
        return []
    }
}
```

If you know of a better way, please let me know! Also feel free to leave a comment with any other alternative solution, even in other languages.
