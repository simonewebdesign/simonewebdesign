---
layout: post
title: "Ruby is Magic"
date: 2014-04-30 00:07:00 +0000
comments: true
categories: Ruby
---
Have you ever heard about [Ruby](http://ruby-lang.org/)? It's my favourite programming language. It was invented in Japan, which is probably the most amazing country in the world, and I think no language can beat Ruby when it comes to magic. Yes: Ruby is Magic.

You don't believe me, do you? Fair enough, but let me show you why Ruby is so awesome.

## You can read and write it like English.

Yes, it's true. Ruby is so simple and intuitive that you can think in English before writing some Ruby code. For example:

``` ruby
def speak_english
  print "Hello, world!"
end
```

The code above is a Ruby function (or method) declaration. So, when you want to run the `speak_english` function, you do it this way:

``` ruby
speak_english
Hello, world! => nil
```

You may have noticed the `nil`: what's that? It's just nothing, literally. It represents the void (emptiness, no value at all). In other languages, such as SQL (the mother tongue of databases), you can find it as `NULL`.

## In Ruby, everything is an object.

Do you know about OOP? It means Object-Oriented Programming, and it's probably the most important programming paradigm ever invented so far. Ruby takes full advantage of OOP. And when I say full, I literally mean: *everything*, in Ruby, is an object. Even numbers! If you know at least one programming language, say Java, you must be aware of the fact that Java numbers are primitive types, which mean that they're not objects. In Ruby, things are different.

Let's make an example. Let's say you want to use the `speak_english` function 3 times. In Java, you'd do something like:

``` java
public class HelloWorld
{
    public static void main(String[] args)
    {
        for (int i = 0; i < 3; i++)
        {
            speakEnglish();
        }
    }

    public static void speakEnglish()
    {
        System.out.println("Hello, world!");
    }
}
```

So much code for something so simple... in Ruby, instead, you can do this:

``` ruby
3.times do
  speak_english
end
Hello, world! Hello, world! Hello, world! => 3
```

See? I called a function on a number! Cool, isn't it? And I used only 3 lines of code :-)

## Ruby is clear, concise and understandable.

I was a PHP developer when I discovered Ruby. Although I had a bit of OOP background, I was used to write PHP code in a procedural style. Procedural code looks something like:

``` javascript
doThis();
doThat();
doSomethingElse();
```

There's absolutely nothing wrong with this approach, apart from the fact that it starts being cumbersome, sometimes... because it's not Object-Oriented. I'll make one last example, taken from a beautiful [StackOverflow's answer](https://stackoverflow.com/questions/1113611/what-does-ruby-have-that-python-doesnt-and-vice-versa#answer-4102608).

Reverse the words in this string:

    backwards is sentence This

So the final result must be:

    This sentence is backwards

When you think about how you would do it, you'd do the following:

- Split the sentence up into words
- Reverse the words
- Re-join the words back into a string

In PHP, you'd do this:

``` php
$sentence = "backwards is sentence This";
$splitted = explode(" ", $sentence);
$reversed = array_reverse($splitted);
$rejoined = implode(" ", $reversed);
```

In Python:

``` python
sentence = "backwards is sentence This"
splitted = sentence.split()
reversed = reversed(splitted)
rejoined = " ".join(reversed);
```

And Ruby:

``` ruby
sentence = "backwards is sentence This"
splitted = sentence.split
reversed = splitted.reverse
rejoined = reversed.join
```

Every language required 4 lines of code. Now let's compare the one-liners.

### PHP

``` php
implode(" ", array_reverse(explode(" ", $sentence)));
```

### Python

``` python
" ".join(reversed(sentence.split()))
```

### Ruby

``` ruby
sentence.split.reverse.join " "
```

Now, can you see the beautiness of Ruby? It's just... [Magic](https://www.youtube.com/watch?v=UzH0o3X0oB0).

I love Ruby.
