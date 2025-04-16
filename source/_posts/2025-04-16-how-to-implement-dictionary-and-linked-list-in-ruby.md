---
layout: post
title: How to implement Dictionary and LinkedList in Ruby
date: 2025-04-16
categories: Ruby
comments: yes
---

Dictionaries and linked lists are very much two ubiquitous data structures. There's probably almost no programming language that doesn't already implement their own version of them, and Ruby is no exception. Well, _sort of_: while there's `Hash` that functions as a key-value store, there's no built-in `LinkedList` class—though there are arrays.

## [Who's this article for?](#whos-this-article-for)

I decided to do this as an exercise to prepare for job interviews (but also, let's be honest, [it's just a fun thing to do](https://joshcollinsworth.com/blog/the-blissful-zen-of-a-good-side-project)), so this article is mainly for myself. I'm writing this article as a byproduct of what I'm (re)learning in the process, and I'm hoping it will be useful, not just for my future self, but for you, the reader.

I'm planning to write a series of articles reimplementing these two data structures in some other languages as well, so this is hopefully just the beginning: stay tuned for more!

## [What's the goal, precisely?](#whats-the-goal-precisely)

Glad you asked. The aim is to implement a **minimalistic API that is both simple and intuitive**. For this reason I will take the wonderful Elm language as an inspiration: Elm's APIs are well-designed and avoid unnecessary complexity, so that should serve my main purpose: refreshing my knowledge of algorithms and data structures.

I'm not going to reimplement all the methods, just the essentials; I also won't cover what a dictionary or a linked list are; that's out of scope for this article.

Let's get started.

## [Dictionary API](#dictionary-api)

### `empty`

Returns an empty dictionary.

Type: `Dict k v`

### `insert`

Inserts a key-value pair into the dictionary.

Type: `Dict k v → k → v → Dict k v`

### `get`

Retrieves the value for a given key, returning `nil` if the key is absent.

Type: `Dict k v → k → Maybe v`

### `remove`

Removes a key and its associated value from the dictionary.

Type: `Dict k v → k → Dict k v`

### `contains`

Checks if a key exists in the dictionary.

Type: `Dict k v → k → Bool`

### `size`

Returns the number of elements in the dictionary.

Type: `Dict k v → Int`


### `keys`

Returns a list of all the keys in the dictionary.

Type: `Dict k v → List k`

### `values`

Returns a list of all the values in the dictionary.

Type: `Dict k v → List v`


### `map`

Transforms each key-value pair in the dictionary using a function.

Type: `(k → v → a) → Dict k v → Dict k a`


### `fold`

Reduces the dictionary to a single value by applying a function to each key-value pair.

Type: `(k → v → a → a) → a → Dict k v → a`

## [Linked List API](#linked-list-api)

### `empty`

Returns an empty list.

Type: `List a`

### `cons`

Adds an element to the front of the list.

Type: `a → List a → List a`

### `head`

Returns the first element of the list, if it exists.

Type: `List a → Maybe a`

### `tail`

Returns the list without the first element.

Type: `List a → List a`

### `is_empty`

Checks if the list is empty.

Type: `List a → Bool`

### `length`

Returns the number of elements in the list.

Type: `List a → Int`

### `map`

Transforms each element of the list using a function.

Type: `(a → b) → List a → List b`

### `filter`

Filters the list based on a predicate function.

Type: `(a → Bool) → List a → List a`

### `reduce`

Reduces the list to a single value.

Type: `(a → b → b) → b → List a → b`

## [Notes and assumptions](#notes-and-assumptions)
