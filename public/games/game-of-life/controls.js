var startButton = document.createElement('button')
startButton.id = 'start'
startButton.innerHTML = 'Generate'
document.body.appendChild(startButton)

var stopButton = document.createElement('button')
stopButton.id = 'stop'
stopButton.innerHTML = 'Freeze'
stopButton.disabled = true
document.body.appendChild(stopButton)

var generationCounter = document.createElement('input')
generationCounter.id = 'generation'
generationCounter.value = 0
generationCounter.disabled = true
generationCounter.title = 'Generations'
document.body.appendChild(generationCounter)

var populationCounter = document.createElement('input')
populationCounter.id = 'population'
populationCounter.value = 0
populationCounter.disabled = true
populationCounter.title = 'Population'
document.body.appendChild(populationCounter)
