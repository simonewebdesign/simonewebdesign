---
layout: post
title: How to insert values of multiple types in Rust's HashMap
date: 2020-07-06
comments: true
published: false
categories:
  - rust
---

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

    a: 1
    b: 2

In the example above, the type of `map` is `HashMap<&str, &str>`. In other words, both keys and values are of type `&str`.
What if we want the values to be of type `&str` _and_, say, `i32`?

This won't work:

```
use std::collections::HashMap;

fn main() {
    let mut map = HashMap::new();

    map.insert("a", "1");
    BEGINMARKmap.insert("b", 2);ENDMARK

    for (key, value) in &map {
        println!("{}: {}", key, value);
    }
}
```

If we try it, we get this compile time error:

```
error[E0308]: mismatched types
  --> src/main.rs

     map.insert("b", 2);
                     ^ expected `&str`, found integer
```

So how do we insert multiple value types in a `HashMap`? We have several options, each of them with its own trade-offs.

## Use an `enum`

We can define our own `enum` to model our value type, and insert that into the hashmap:

```
use std::collections::HashMap;

#[derive(Debug)] // TODO hightlight ghange
enum Value {
    Str(&'static str),
    Int(i32),
}

fn main() {
    let mut map = HashMap::new();

    map.insert("a", Value::Str("1"));
    map.insert("b", Value::Int(2)); // TODO find a way to highlight change? would be cool.

    for (key, value) in &map {
        println!("{}: {:?}", key, value);
    }
}
```

This prints:

```
    a: Str("1")
    b: Int(2)
```

This is similar to a union type(TODO: ADD LINK?). By inserting values of type `Value::*`, we are effectively saying that the map can accept types that are either string, integer, or mixed.


THIS WHOLE SECTION CAN BE DISCARDED
## Trait objects

For this to work, we need to find a common trait between the types that we would like to insert.

```
```


```
use std::collections::HashMap;
// use std::fmt::Display;
// use std::fmt;



fn main() {
    let mut map = HashMap::new();

    insert_into(map, "a".to_string(), "1");
    insert_into(map, "b".to_string(), 2 as &str); // TODO find a way to highlight change? would be cool.

    for (key, value) in &map {
        println!("{}: {:?}", key, value);
    }
}

fn insert_into<V>(map: HashMap<String, V>, key: String, value: V)
where V: Display
{
    map.insert(key, value);
}

error I get without a fn: `impl Trait` not allowed outside of function and inherent method return typesrustc(E0562)

```

## Trait objects

```
use std::collections::HashMap;

fn main() {
    let mut map = HashMap::new();

    // map.insert

    insert(map, "a", "1");
    insert(map, "b", 2);

    for (key, value) in &map {
        println!("{}: {}", key, value);
    }
}

fn insert<K, V>(map: HashMap<K, V>, k: K, v: V) -> Option<V> {
    map.insert(k, v.to_string())
}
```

END OF THE WHOLE SECTION TO DISCARD

## Use a `Box`

We can wrap our types in the `Box` struct:

```
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

This doesn't work right away. If we try to run this, we get the "mismatched types" error:

error[E0308]: mismatched types
   --> src/main.rs

     map.insert("b", Box::new(2));
                              ^ expected `&str`, found integer

Luckily we can fix this by explicitly declaring the type of our map:

```
    let mut map: HashMap<&str, Box<dyn Display + 'static>> = HashMap::new();
```

This works because we are actually storing instances of `Box`, not primitive types; `dyn Display` means the type of the _trait object_ `Display`. `Display`, in this particular case, happens to be a common trait between `&str` and `i32`.


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

You may wonder what would happen if we were to use the type `dyn Display` without the `Box` wrapper. If we try that, we'd get this error:

```
error[E0277]: the size for values of type `(dyn std::fmt::Display + 'static)` cannot be known at compilation time
   --> src/main.rs

     let mut map: HashMap<&str, (dyn Display + 'static)> = HashMap::new();
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ doesn't have a size known at compile-time

    = help: the trait `std::marker::Sized` is not implemented for `(dyn std::fmt::Display + 'static)`
    = note: to learn more, visit <https://doc.rust-lang.org/book/ch19-04-advanced-types.html#dynamically-sized-types-and-the-sized-trait>
    = note: required by `std::collections::HashMap
```

This error may be confusing at first, but it actually makes sense. The Rust Programming Language book explains this very well:

> Rust needs to know how much memory to allocate for any value of a particular type, and all values of a type must use the same amount of memory.

The `Box<T>` is a _pointer type_. It lets us allocate data on the heap rather than the stack, and keeps a reference to the data in the stack in the form of a pointer, which is of fixed size.

## Use separate maps for each type

Here we're not actually using a HashMap with separate types, but rather two maps, each with its own type. It's a bit more verbose and perhaps not an ideal solution, but it's worth keeping in mind that this works too:

```
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

The output is naturally the same:

    a: 1
    b: 2

