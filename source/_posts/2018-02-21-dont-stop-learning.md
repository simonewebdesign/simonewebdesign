---
layout: post
title: "Don't stop learning"
description: "Just don't stop learning, ever. Keep on practicing, and you too will discover beautiful things."
date: 2018-02-21
comments: true
categories:
  - Ruby
---

Back in the days, when I got serious about becoming a "real programmer", I decided I wanted to learn Java.

I didn't know anything about OOP, Design Patterns, Single Responsibility... all I knew was some PHP, Visual Basic, and database design stuff. That was it.

So I went to a book store and I bought this book about Object-Oriented Programming in Java 6. It was a massive book, probably around 1000 pages of code and programming best practices, and I read like 80% of it. Some parts were too advanced for me, but I learned a lot.

I used to like Java. I thought, "so this is what real programming looks like, with classes and inheritance. That's the right way".

I actually believed this for a while, until that day...

One day I went to this website, projecteuler.net, which is basically a way to prove your skills by solving difficult programming challenges, and learn in the process.

It was years ago, but I remember I solved the first couple exercises pretty easily. The third one was a bit harder. Here's the original text:

> A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

> Find the largest palindrome made from the product of two 3-digit numbers.

<small>Source: https://projecteuler.net/problem=4</small>

I spent a few hours on it before coming up with this:

```java
import static java.lang.System.out;

import java.util.ArrayList;
import java.util.List;

public class Euler4
{
  static final int MIN = 100;
  static final int MAX = 999;

  public static List<Integer> getPalindromes(int min, int max)
  {
    List<Integer> palindromes = new ArrayList<>();
    for (int i=max; i >= min; i--)
    {
      for (int j=max; j >= min; j--)
      {
        int product = i * j;
        if (isPalindrome(new Integer(product).toString()))
          palindromes.add(product);
      }
    }
    return palindromes;
  }

  public static boolean isPalindrome(String str)
  {
    if (str.length() < 0) return false;
    if (str.length() <= 1) return true;

    char firstChar = str.charAt(0);
    char lastChar = str.charAt(str.length()-1);

    if (firstChar == lastChar) {
      return isPalindrome(str.substring(1, str.length()-1));
    }
    return false;
  }

  public static int getHighestNumber(List<Integer> numbers)
  {
    int highestNumber = -1;
    for (int number : numbers)
      if (number > highestNumber)
        highestNumber = number;
    return highestNumber;
  }

  public static void main(String[] args)
  {
    List<Integer> palindromes = getPalindromes(MIN, MAX);
    out.println(getHighestNumber(palindromes));
  }
}
```

It's 46 lines of code, without counting blank lines. Not too bad, right?

Ok, don't be mean. I know that's probably shitty code, but it was my own solution and I was quite proud of it.

Now, when you finish a challenge successfully, you're given access to the forum, where other programmers post their own solutions in many different languages.

That's where I first discovered [Ruby](/ruby-is-magic/).

I was reading the thread about the problem I just solved, when I stumbled across this Ruby solution:

```ruby
m = 0
901.upto(999) {|a|
  901.upto(999){|b|
    s = (a*b).to_s
    m = [m, a*b].max if s == s.reverse
  }
}
puts m
```

And I was like, "wow, seriously? Only 8 lines of code?".

I couldn't believe my eyes. I was staring at something marvelous; some beauty that I never came across before.

Ruby is an object-oriented programming language that focuses on expressiveness and readability.

It was love at first sight. I started reading about this amazing language, about the fact that everything in Ruby is an object, even integers, and that you can write code like `3.times { print "Hello" }` to simply print "Hello" 3 times. It was like reading English, and I felt truly amazed, humbled, and inspired.

---

Anyway, that's just part of my story about becoming a better programmer. I'm not sure what the point is, I just felt like writing it down. But if, like me, you're one of those people that need some 'takeaway' from a story, I guess it should be this:

> Just don't stop learning, ever.

> Keep on learning and practicing, and you too will discover beautiful things.
