---
layout: post
title: Inserting values of multiple types in Rust's HashMap
date: 2020-07-06
updated: 2020-07-07
comments: true
published: true
---

I was building a generic data store with Rust and I needed to implement a heterogeneous collection of keys and values. Essentially what I needed was a dictionary, but with values of dynamic type, like both strings and integers at the same time.

Rust is a statically typed language and, due to the memory safety guarantees we are given, all values of some type must have a known, fixed size at compile time, therefore we are not allowed to create a collection of multiple types. However, <a href="https://doc.rust-lang.org/reference/dynamically-sized-types.html" rel="external nofollow">dynamically sized types</a> also exist, and in this article I'll show how to use them.

<!--more-->

Say we have a <a href="https://doc.rust-lang.org/std/collections/struct.HashMap.html" rel="external nofollow">`HashMap`</a> and we want to add more than one value type to it.

For example:

```rust
use std::collections::HashMap;

fn main() {
    let mut map = HashMap::new();

    map.insert("a", "1");
    map.insert("b", "2");

    for (key, value) in &map {
        println!("{}: {}", key, value);
    }
}
```

This prints:

```rust
a: 1
b: 2
```

In the example above, the type of `map` is `HashMap<&str, &str>`. In other words, both keys and values are of type `&str`.
What if we want the values to be of type `&str` _and_, say, `i32`?

This won't work:

```rust
use std::collections::HashMap;

fn main() {
    let mut map = HashMap::new();

    map.insert("a", "1");
    map.insert("b", 2);

    for (key, value) in &map {
        println!("{}: {}", key, value);
    }
}
```

If we try it, we get this compile time error:

```rust
error[E0308]: mismatched types
  --> src/main.rs

     map.insert("b", 2);
                     ^ expected `&str`, found integer
```

So how do we **insert multiple value types** in a `HashMap`? We have several options, each of them with its own trade-offs.

## Option #1: Use an `enum`

We can define our own <a href="https://doc.rust-lang.org/std/keyword.enum.html" rel="external nofollow">`enum`</a> to model our value type, and insert that into the hashmap:

```rust
use std::collections::HashMap;

#[derive(Debug)]
enum Value {
    Str(&'static str),
    Int(i32),
}

fn main() {
    let mut map = HashMap::new();

    map.insert("a", Value::Str("1"));
    map.insert("b", Value::Int(2));

    for (key, value) in &map {
        println!("{}: {:?}", key, value);
    }
}
```

This prints:

```rust
a: Str("1")
b: Int(2)
```

This is similar to a <a href="https://doc.rust-lang.org/reference/items/unions.html" rel="external nofollow">union type</a>. By inserting values of type `Value::*`, we are effectively saying that the map can accept types that are either string, integer, or any other composite type we wish to add.

## Option #2: Use a `Box`

We can wrap our types in the <a href="https://doc.rust-lang.org/std/boxed/struct.Box.html" rel="external nofollow" title="std::boxed::Box">`Box`</a> struct:

```rust
use std::collections::HashMap;

fn main() {
    let mut map = HashMap::new();

    map.insert("a", Box::new("1"));
    map.insert("b", Box::new(2));

    for (key, value) in &map {
        println!("{}: {}", key, value);
    }
}
```

This doesn't compile right away. If we try to run this, we get a "mismatched types" error:

```rust
error[E0308]: mismatched types
--> src/main.rs

    map.insert("b", Box::new(2));
                             ^ expected `&str`, found integer
```

Luckily we can fix this by explicitly declaring the type of our map:

```rust
    let mut map: HashMap<&str, Box<dyn Display + 'static>> = HashMap::new();
```

This works because we are actually storing instances of `Box`, not primitive types; `dyn Display` means the type of the _trait object_ `Display`. In this case, `Display` happens to be a common trait between `&str` and `i32`.

```rust
use std::collections::HashMap;
use std::fmt::Display;

fn main() {
    let mut map: HashMap<&str, Box<dyn Display + 'static>> = HashMap::new();

    map.insert("a", Box::new("1".to_string()));
    map.insert("b", Box::new(2));

    for (key, value) in &map {
        println!("{}: {}", key, value);
    }
}
```

You may wonder what would happen if we were to use the type `dyn Display` without the `Box` wrapper. If we try that, we'd get this nasty error:

```rust
error[E0277]: the size for values of type `(dyn std::fmt::Display + 'static)` cannot be known at compilation time
   --> src/main.rs

     let mut map: HashMap<&str, (dyn Display + 'static)> = HashMap::new();
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ doesn't have a size known at compile-time

    = help: the trait `std::marker::Sized` is not implemented for `(dyn std::fmt::Display + 'static)`
    = note: to learn more, visit <https://doc.rust-lang.org/book/ch19-04-advanced-types.html#dynamically-sized-types-and-the-sized-trait>
    = note: required by `std::collections::HashMap
```

This error may be confusing at first, but it actually makes sense. <a href="https://doc.rust-lang.org/book/" rel="external nofollow">The Rust Programming Language book</a> explains this very well in the <a href="https://doc.rust-lang.org/book/ch19-04-advanced-types.html" rel="external nofollow">Advanced Types</a> chapter:

> “Rust needs to know how much memory to allocate for any value of a particular type, and all values of a type must use the same amount of memory.”

The `Box<T>` type is a <a href="https://doc.rust-lang.org/reference/types/pointer.html" rel="external nofollow">_pointer type_</a>. It lets us allocate data on the heap rather than the stack, and keeps a reference to the data in the stack in the form of a pointer, which is of fixed size.

## (Not an) Option #3: Use separate maps for each type

Here we're not actually using a `HashMap` with separate types, but rather two maps, each with its own type. It's a bit more verbose and perhaps not the solution you're looking for, but it's worth keeping in mind that this works too:

```rust
use std::collections::HashMap;

fn main() {
    let mut strings_map = HashMap::new();
    let mut integers_map = HashMap::new();

    strings_map.insert("a", "1");
    integers_map.insert("b", 2);

    for (key, value) in &strings_map {
        println!("{}: {}", key, value);
    }

    for (key, value) in &integers_map {
        println!("{}: {}", key, value);
    }
}
```

It feels much simpler! And the output is naturally the same:

```rust
    a: 1
    b: 2
```

## Conclusion

Rust is very strict when it comes to polymorphic types. As you've seen, there are ways to achieve it, but they don't feel as straightforward as with other dynamic languages such as Ruby or Python. Sometimes though it's useful to make one step back and look at the actual problem we're trying to solve. Once I did that, I realized that I didn't necessarily have to limit myself to a single data structure, so I went for the last option.

I'm still a beginner with Rust, so I might have missed on a better solution. <a href="https://doc.rust-lang.org/book/ch17-02-trait-objects.html" rel="external nofollow">Trait Objects</a> could be one: I've experimented with them, but they weren't quite was I was looking for. If you have any suggestions or know of other possible solutions, feel free to comment below!

---

**Update**: <a href="https://twitter.com/alilleybrinker/status/1280185393258926088" rel="external nofollow">@alilleybrinker</a> on Twitter pointed out two caveats to be aware of. One is about the meaning of the `'static` _bound_: when used on a generic type, any references inside the type must live as long as `'static`. However, by adding `'static` we are also effectively saying that the values inside the `Box` won't contain references. The other caveat is that, when using `dyn Display`, the original types are erased, so the available methods are only those known from the `Display` trait.
