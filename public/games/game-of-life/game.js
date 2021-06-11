/* THE GAME OF LIFE
**
** 1st rule
** Any live cell with fewer than two live neighbours dies, as if caused by under-population.
**
** 2nd rule
** Any live cell with two or three live neighbours lives on to the next generation.
**
** 3rd rule
** Any live cell with more than three live neighbours dies, as if by overcrowding.
**
** 4th rule
** Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
**
*/
var world = new World
world.create()
world.spawn('glider', 3, 3)
world.spawn('glider', 15, 20)
world.spawn('glider', 30, 4)


var intervalId = 0
startButton.addEventListener('click', function(){

  // Toggle button state
  this.disabled = true
  stopButton.disabled = false

  intervalId = setInterval(function() {

    world.generate()
    world.renderNextGeneration()

    // Update counters
    generationCounter.value = world.generationCount
    populationCounter.value = world.populationCount

  }, world.speed)

}, false)

stopButton.addEventListener('click', function(){

  // Toggle button state
  this.disabled = true
  startButton.disabled = false

  // Freeze generation
  clearInterval(intervalId)

}, false)
