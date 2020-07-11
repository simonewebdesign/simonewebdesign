---
layout: post
title: "Making a game from scratch in HTML5"
date: 2014-12-01 17:06:53 +0100
comments: true
categories: JavaScript
---

> "Pong is one of the earliest arcade video games; it is a tennis sports game featuring simple two-dimensional graphics." - Wikipedia

Have you ever dreamed of building a game in JavaScript? I did, and I also managed to make my first one. Of course I also wrote some tips and gotchas to help you complete this nice challenge.


## How to make Pong in HTML5 canvas

Pong, at it's core, is an extremely simple game. That's why it's a good one to begin with if you have just started learning game design basics. Of course you could start with <a href="//www.gamefromscratch.com/post/2013/08/01/Just-starting-out-what-games-should-I-make.aspx" rel="external nofollow">many other games</a>, but if you are looking for something relatively simple to build, Pong really is one of the simplest games ever made.

<abbr title="As far as I know">AFAIK</abbr>, there are at least two ways of doing it: I personally call them the *"simple way"* and the *"hard way"*. I did both, but first let's explore the simple one.


### Project structure

I aimed to make it as simple as possible, so I just created one HTML file that is referencing few JavaScript files. You may ask, why not a whole single file? Because it's usually preferable to have many little files rather than one massive plate of spaghetti code. So here's served the project's structure:

```
index.html
canvas.js
game.js
keyboard.js
main.js
render.js
reset.js
update.js
```

**index.html** is our single entry point to the game.

**canvas.js** contains the code for initializing the `canvas` <abbr title="Document Object Model">DOM</abbr> object and the 2D context.

**game.js** contains the game objects. This file will be executed only once at the beginning, when the game loads.

**keyboard.js** has the keyboard bindings.

**main.js** is perhaps the most important file, because it contains the main game loop.

**render.js** does... the rendering. (you don't say?)

**reset.js** is for resetting the game to the initial state, called every time a player wins.

**update.js** contains 90% of the game logic, and obviously is for updating the game state (before rendering).


### The main loop

The main loop is at the core of our game. Maybe it's hard to believe, but virtually every single videogame in the world lives and dies <a href="//designoidgames.com/2013/01/game-programming-basics-time/" rel="external nofollow">within a loop</a>.

Implementing a game loop is a lot simpler than you think, but it's not the focus of this tutorial. The resource I highly recommend for getting started is [How to make a simple HTML5 Canvas game](http://www.lostdecadegames.com/how-to-make-a-simple-html5-canvas-game/), by Matt Hackett. All my work is actually based on his tutorial. Read it, and you'll get a basic understanding of the fundamentals of game development.

We want to focus on the game logic now, so for the time being let's pretend our game loop looks like this:

``` javascript
while (true) {
  update(); // update game objects
  render(); // render game objects
}
```

Got it? :-)


### Ball movement

How do we make the ball moving across the screen? In JavaScript, we can define objects with properties. The essential properties of our `ball` object are `position` and `speed`. The `position` represents the *coordinates* where the object is in the canvas space. Example:

``` javascript
var ball = {
  x: 0,
  y: 0,
  speedX: 0,
  speedY: 0
}
```

In order to make it move, we should change its position, and we can do it through the speed. This is the heart of our game:

``` javascript
if (isGameStarted) {
  // Ball movement
  ball.x += ball.speedX * modifier;
  ball.y += ball.speedY * modifier;
}
```

As you can imagine, `isGameStarted` is just a boolean flag. But what's `modifier`? Well, it's the **delta time** of our game loop. Put simply, the <a href="//en.wikipedia.org/wiki/Delta_timing" rel="external nofollow">delta time</a> is the time elapsed between a frame and another. This is very useful because we can use it to calculate how fast the ball should move. Without it, the game would just lag all the time.


### Ball bounce

The game logic is mainly about the ball: it should be able to bounce away from the paddles. How can you implement that? It's pretty simple - have a look at the code below.

``` javascript
// Ball is out of the left boundary
if (ball.x <= 0) {
  // Player 2 wins!
  p2.score++;
  reset(); // reset the game to the initial state
}

// Ball is out of the right boundary
if (ball.x >= canvas.width - ball.size) {
  // Player 1 wins!
  p1.score++;
  reset();
}

// Ball is colliding with the top
if (ball.y <= 0) {
  ball.speedY = Math.abs(ball.speedY);
}

// Ball is colliding with the bottom
if (ball.y + ball.size >= canvas.height) {
  ball.speedY = Math.abs(ball.speedY) * -1; // inverted
}
```

Can you see what's going on in the code? Basically, if the ball goes beyond the canvas' left or right boundaries, all we do is **increment the score and reset the game**. If the ball touches the top or the bottom instead, we **invert its speed on the Y axis**. If you think about it, it's all you need to make something reflect over a surface. So, in other words, if the speed is negative we make it positive, and viceversa.


### Collision detection

What should happen when the ball touches one of the paddles? Fundamentally the same thing explained above: it should bounce away, reflecting on the paddle's surface (and to do this we invert the Y speed). But how do we actually check if they are **colliding**?

The most common kind of collision detection is called **AABB - Axis-Aligned Bounding Boxes**. You can find plenty of resources around the Web explaining how this technique works, so I won't talk about it (have a quick search for *"AABB collision detection"*, or just keep reading). As <a href="http://en.wikipedia.org/wiki/Linus_Torvalds" rel="external nofollow">Linus Torvalds</a> once said,

> “Talk is cheap. Show me the code.”

Here we go:

``` javascript
if (
  ball.x <= (p1.x + p1.width)
  && p1.x <= (ball.x + ball.size)
  && ball.y <= (p1.y + p1.height)
  && p1.y <= (ball.y + ball.size)
) {
  // Ball is colliding with the left paddle
  // Ensure the speed on the X axis is positive
  ball.speedX = Math.abs(ball.speedX);

  // Give the ball a bit of randomness by
  // increasing/decreasing its speed on the Y axis
  ball.speedY = randomize();
}
```

The logic for the right paddle is exactly the same, but the speed on the X axis should be negative instead. In my case I also added a `randomize()` function, so the game will be more interesting - you don't have to implement it this way, but a bit of randomness never hurts in gaming!

``` javascript
function randomize() {
  // Random float between 0 and 999.9
  var _rand = Math.random() * 1000;
  // positive or negative?
  return Math.random() > 0.5 ? _rand : _rand * -1;
}
```

### Paddle movement

We move the paddles with the keyboard. Keyboard controls can be handled simply by keeping track of which key is currently being pressed (watch for the `keydown` event). We can use a simple JavaScript object for that (or an array if you prefer):

``` javascript
// Handle keyboard controls
var keysDown = {};

addEventListener("keydown", function (e) {
  keysDown[e.keyCode] = true;
}, false);

addEventListener("keyup", function (e) {
  delete keysDown[e.keyCode];
}, false);
```

The `keyup` and `keydown` events are the only two we need for handling the whole keyboard. So on `keydown` we add the key; on `keyup` we remove it. Simple.

Of course we are going to need JavaScript objects for the paddles as well. In my game I called them `p1` and `p2`, which can be interpreted as *players* too.

Here's the code:

``` javascript
// Update game objects
var update = function (modifier) {
  if (87 in keysDown) { // P1 holding up (key: w)
    p1.y -= p1.speed * modifier;
  }

  if (83 in keysDown) { // P1 holding down (key: s)
    p1.y += p1.speed * modifier;
  }

  if (38 in keysDown) { // P2 holding up (key: arrow up)
    p2.y -= p2.speed * modifier;
  }

  if (40 in keysDown) { // P2 holding down (key: arrow down)
    p2.y += p2.speed * modifier;
  }
}
```

### Rendering the objects in the canvas

Here's the `render()` function, in all its glory:

``` javascript
var render = function () {
  ctx.fillStyle = "#0F0"; // green

  // P1
  ctx.fillRect(p1.x, p1.y, p1.width, p1.height);

  // P2
  ctx.fillRect(p2.x, p2.y, p2.width, p2.height);

  // ball
  ctx.fillRect(ball.x, ball.y, ball.size, ball.size);

  // Text options
  ctx.fillStyle = "rgb(250, 250, 250)";
  ctx.font = "18px Helvetica";
  ctx.textAlign = "left";
  ctx.textBaseline = "top";

  // P1 Score
  ctx.fillText(p1.score, 32, 32);

  // P2 Score
  ctx.fillText(p2.score, canvas.width - 32, 32);
};
```
It's probably worth mentioning that you can use `JSON.stringify()` to debug your objects directly in the canvas, e.g.:

``` javascript
// Debugging the ball object
ctx.fillText("ball: " + JSON.stringify(ball), 0, 0);
```

However, I don't recommend it. Just use whatever your browser is offering! If you are a web developer you surely know that there's a built-in JavaScript console for debugging in your browser (if you don't, search for *developer tools*).

### Resetting the game

We need to reset the game every time a player scores. The logic is very simple, we just need to provide default values for our objects. Example below.

``` javascript
// Reset the game
var reset = function () {
  isGameStarted = false;

  ball.x = (canvas.width - ball.size) / 2;
  ball.y = (canvas.height - ball.size) / 2;

  ball.speedX = randomize(); // randomly start going left or right
  ball.speedY = 0;
}
```

---

This is the main logic of Pong. However, it's not perfect, and it could be improved a lot in several ways... for example by implementing **physics rules** (or by using a physics engine, that has already done the job for us). We have just simulated the reflection of a ball on a surface, but it's not realistic at all - let's make it better.


## The "hard way"

In a *proper* Pong game, you can usually control where the ball goes. It could have a steeper or shallower angle of reflection, based on where the ball landed. Should it land on one of the edges of the paddle, the collision should be inelastic. In case it lands exactly on the middle of the paddle, the collision should be <a href="http://hyperphysics.phy-astr.gsu.edu/hbase/elacol.html" rel="external nofollow">totally elastic</a>.

In order to implement physics rules in a game, you should have an understanding of basic vector math, trigonometry and - of course - physics. But don't fear, you don't have to know everything: just the basics. I personally didn't know much about physics, but I learned it by reading about it.

Here are some useful resources on the Web:

- Math lessons: <a href="//www.mathsisfun.com/" rel="external nofollow">www.mathsisfun.com</a>
- Physics lessons: <a href="//www.physicsclassroom.com/" rel="external nofollow">www.physicsclassroom.com</a>
- Vector math cheatsheet: <a href="//higherorderfun.com/blog/2012/06/03/math-for-game-programmers-05-vector-cheat-sheet/" rel="external nofollow">higherorderfun.com/blog/2012/06/03/math-for-game-programmers-05-vector-cheat-sheet/</a>
- Linear algebra for game developers: <a href="//blog.wolfire.com/2009/07/linear-algebra-for-game-developers-part-1/" rel="external nofollow">blog.wolfire.com/2009/07/linear-algebra-for-game-developers-part-1/</a>

Let's explore together the potential of 2D vectors.


### Using 2D Vectors

The main thing you'll have to understand is how vectors are used in game development. As an example, let's go back to our `ball` object and modify it to use vectors. It will look like this:

``` javascript
var ball = {
  position: new Vector({ x: 0 , y: 0 }),
  velocity: new Vector({ x: 0 , y: 0 })
}
```

Four values at the price of two attributes! And this is a lot better now, not only because we are using less attributes, but because we can use vector math. Believe me, vectors simplify your game a lot.

You may have noticed that I didn't use `speed`, but I used `velocity` instead. The reason is that `speed` is a *scalar* quantity, while `velocity` is a *vector* quantity. Put simply, `speed` is an information that's *contained* in `velocity`! You may want to <a rel="external nofollow" href="//www.physicsclassroom.com/class/1DKin/Lesson-1/Speed-and-Velocity">read about it</a>, albeit not directly related to programming.


### A proper ball reflection

We can implement proper reflection (not a fake one) by using this JavaScript function:

``` javascript
var ball = {
  // the velocity vector
  velocity: new Vector(),

  /*
  * The formula:
  *
  *  R = 2(V · N) * N - V
  *
  * V: velocity vector
  * N: a normalized vector of the plane surface (e.g. paddle or wall)
  * R: the reflected velocity vector
  */
  deflect: function (N) {
    var dot = this.velocity.dot(N);
    var v1 = N.multiplyScalar(2 * dot);
    this.velocity = v1.subSelf(this.velocity);
  }
}

```

This is how I've implemented it by using a vector library I found on the Web (find the <a rel="external nofollow" href="https://github.com/dudeOMG/pong/blob/master/js/vector2.js">source code on GitHub</a>). Given a paddle's normal, it will reflect any vector, but you have to make sure the paddle's normal is a unit vector (in other words, it's *normalized*).


## Conclusion

I hope you enjoyed this article. Who's following my blog since the beginning will probably remember [my first blog post](/playing-around-with-javascript/). It was more than 2 years ago, and at that time I was really excited by the idea to build a game with JavaScript. I finally did it, and it has been fun indeed! However, I learned a big lesson: although it was fun, it wasn't really worth reinventing the wheel. So, if you got through all this tutorial, first of all congratulations! Secondly, consider using a game engine. Thirdly, maybe consider *not* using JavaScript... just use whatever you feel comfortable with. For instance, if you like the Ruby language (I do!) you could use <a rel="external nofollow" href="//opalrb.org/">Opal</a>, a Ruby to JavaScript compiler.


## Demo and source code

You can [play the game here](https://www.simonewebdesign.it/games/pong/).

The <a rel="external nofollow" href="https://github.com/dudeOMG/pong">full source code</a> is on GitHub so you can clone it, fork it and even make your own from scratch, if you feel like it's worth your time. If you are interested in the simple way, checkout the <a rel="external nofollow" href="https://github.com/dudeOMG/pong/releases/tag/v1.0">v1.0 release</a>.
The hard way is in the master branch.

As always, if you have any thoughts or questions, feel free to leave a comment below.

Have fun!

{% comment %}
## Conclusion

Let's face it: building a game from scratch is not easy. HTML5 APIs in my humble opinion are good, but

There are many other concepts I'm not going to talk about, because I don't want to. Not only it would take a big amount of time, but what I'd say wouldn't be great because I don't yet have a good understanding of all the mechanics. By the way, I hope I have been helpful, at least to some degree.

Oh by the way, you'll be better off by using a library! Trust me: this is the big lesson I learned while writing this game. With a library, not only you'll be faster on completing the game, but the quality of your game will be better, and you'll be happier in the end.

The last thing I feel to say is, please, don't just copy and paste. Try to understand the logic first. I mean, I actually don't mind if you copy all the code and you make big money with it (I'd be surprised if you could, by the way!). I made this simple game in my spare time and I did it just for fun, so I hope you can do the same :)
{% endcomment %}
