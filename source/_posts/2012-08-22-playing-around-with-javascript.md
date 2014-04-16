---
title: Playing around with JavaScript
author: Simone Vittori
layout: post
permalink: /blog/playing-around-with-javascript/
dsq_thread_id:
  - 864271737
categories:
  - JavaScript
tags:
  - oop
  - play
  - programming
---
<div id="jbID-38" class="jbPost">
  <p>
    Have you ever played a videogame on the JavaScript console? No? Well, keep reading!
  </p>
  
  <p>
    I&#8217;m a huge <abbr title="Object Oriented Programming">OOP</abbr> fan, and I love how <abbr title="Object Oriented Programming">OOP</abbr> could potentially represent any kind of real life object. For example, let&#8217;s say we want to depict an <strong>animal</strong>. It&#8217;d be a cat, a dog, an alligator, etc..
  </p>
  
  <p>
    The first attribute that comes to my mind is <em>wildness</em>. Cats and dogs are usually domestic, while alligators aren&#8217;t. So, our <code>Animal</code> object should have a boolean property called <code>isWild</code>.
  </p>
  
  <pre>function Animal() { 
  this.isWild = true; 
}</pre>
  
  <p>
    Thinking more deeply, an animal can have a lot of properties, like <code>name</code>, <code>age</code>, <code>weight</code>&#8230; and so on.
  </p>
  
  <pre>function Animal() { 
  /* properties */ 
  this.isWild = true; 
  this.name = ''; 
  this.sound = '';
  this.height = 0; // cm 
  this.weight = 0; // kg 
  this.speed = 0; // km/h 
  this.age = 0; // years old 
}</pre>
  
  <p>
    But a real life animal can also do things like eating, running, crying&#8230; so let&#8217;s add some cool methods to our brand new class:
  </p>
  
  <pre>function Animal() {

  /* properties */ 

  /* methods */
  this.cry = function() { 
    console.log(this.name + ' says: ' + this.sound + '!'); 
  }
  this.run = function() { 
    console.log(this.name + ' is running at ' + this.speed + 'km/h!');
  }
  this.eat = function() { 
    console.log(this.name + ' is eating!'); 
  }
}</pre>
  
  <p>
    The methods declared above are the simplest we could implement, but what if we want to be as close as possible to real life?
  </p>
  
  <p>
    An animal could be carnivorous, erbivorous, or even omnivorous. We could implement these as animals&#8217; attributes, but I prefer a slightly different solution: I&#8217;d set a property called <code>eats</code>, that is an array defining all foods that our animal can actually eat. Foods are just strings.
  </p>
  
  <pre>function Animal() { 

  /* properties */ 
  this.eats = []; // an empty array

  /* methods */ 
  this.eat = function(food) { 
    if (food) { 
      if ( inArray(food, this.eats) ) { 
        console.log(this.name + ' eats some ' + food + '!'); 
        return true; 
      } else { 
        console.log(this.name + ' can\'t eat ' + food + '!'); 
        return false; 
      } 
    } else { 
      console.log('You should have something edible.'); 
      return false; 
    } 
  }
}</pre>
  
  <p>
    Straightforward, isn&#8217;t it? We can now create as many <code>Animal</code> instances as we want!
  </p>
  
  <pre>var aKitten = new Animal,
    anotherKitten = new Animal,
    aDog = new Animal;</pre>
  
  <p>
    But hey, these are just generic <code>Animal</code> instances&#8230; what if we want to create a <code>Cat</code> instance, or a <code>Dog</code> instance?
  </p>
  
  <p>
    Simple! Let&#8217;s extend the <code>Animal</code> class!
  </p>
  
  <p>
    Unfortunately there&#8217;s no built-in concept of inheritance in JavaScript. If you are looking for better solutions on how to simulate inheritance, I&#8217;ll suggest you reading <a title="Simple JavaScript inheritance" href="http://ejohn.org/blog/simple-javascript-inheritance/">this nice article</a> by John Resig. In my example we&#8217;ll simulate the same behaviour by declaring new classes (that are, in fact, just functions):
  </p>
  
  <pre>function Cat(){ 
  this.inheritFrom = Animal; 
  this.inheritFrom(); 
} 
function Dog(){ 
  this.inheritFrom = Animal; 
  this.inheritFrom(); 
}</pre>
  
  <p>
    <strong>And now, let&#8217;s have fun with the console!</strong><br /> <small>If you don&#8217;t know how to open the JavaScript console in your browser, <a title="How to open the JavaScript console" href="http://webmasters.stackexchange.com/questions/8525/how-to-open-the-javascript-console-in-different-browsers" target="_blank">read here</a>.</small>
  </p>
  
  <pre>var cat = new Cat; 
&gt;&gt;&gt; undefined 
cat.name = "Kitty"; 
&gt;&gt;&gt; "Kitty"
cat.sound = "Meeow";
&gt;&gt;&gt; "Meeow"
cat.eats = ["meat", "fishbones"];
&gt;&gt;&gt; ["meat", "fishbones"]
cat.eat("fishbones");
Kitty eats some fishbones! 
&gt;&gt;&gt; true
cat.eat("a pair of shoes"); 
Kitty can''t eat a pair of shoes! 
&gt;&gt;&gt; false
cat.cry();
Kitty says: Meeow!
&gt;&gt;&gt; undefined</pre>
  
  <pre>var dog = new Dog();
&gt;&gt;&gt; undefined
dog.name = "Doggy";
&gt;&gt;&gt; "Doggy"
dog.sound = "Woof";
&gt;&gt;&gt; "Woof"
dog.cry();
Doggy says: Woof!
&gt;&gt;&gt; undefined
dog.speed = 60;
&gt;&gt;&gt; 60
dog.run();
Doggy is running at 60km/h!
&gt;&gt;&gt; undefined</pre>
  
  <p>
    One day I should create an entire videogame with JavaScript&#8230; would be a lot of fun!
  </p>
</div>