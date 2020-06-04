---
layout: post
title: Metaprogramming in Elixir
date: FIXME@@@@@@2017-04-03
comments: true
categories: elixir
published: false
---

Introduce concepts to the reader by talking about [**homoiconicity**](https://en.wikipedia.org/wiki/Homoiconicity)

Languages such as LISP were (and still are) popular (or gain interest) because of things like homoiconicity and recursion. This paragraph sucks, but you will rephrase it properly.

## File -> String -> AST -> String -> File

(there should really be a circle svg drawing here)

## File to String

`File.read!`

## String to AST

`Code.string_to_quoted`

## Execution?

Is AST executable?

## AST to String

`Macro.to_string`

## String to File

`File.write!`

## Conclusion

This is why I love Elixir. Blah Blah blah. Link to "Ruby is Magic"