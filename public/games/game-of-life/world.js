function World(){ 

  this.rows = 48
  this.cols = 64
  this.speed = 224 // ms
  this.tbody = null
  this.generationCount = 0
  this.populationCount = 0

  this.create = function(){

    this.table = document.createElement('table')
    this.tbody = document.createElement('tbody')
    this.table.appendChild(this.tbody)

    /* HOLDING FEATURE */
    // on mousedown, holding = true
    // on mouseup and on mouseleave, holding = false
    var holding = false,
        timeoutId = 0

    this.table.addEventListener('mousedown', function(){

      // somebody started holding the mouse button:
      // keep track of how much time he holds the button.
      timeoutId = setTimeout(function() {
        holding = true
      }, 10)

    }, false)

    function release() {
      clearTimeout(timeoutId)
      holding = false
    }
    this.table.addEventListener('mouseup',    function(){ release() })
    this.table.addEventListener('mouseleave', function(){ release() })

    // Creating rows and columns...
    for (var r=0; r < this.rows; r++) {

      this.tbody.appendChild(document.createElement('tr'))

      for (var c=0; c < this.cols; c++) {

        var td = this.tbody.rows[r].appendChild(document.createElement('td'))

          // Attaching event handlers for toggling life on cells 
          td.addEventListener('mouseover', function(ev){
            if (holding) {
              this.toggleColor()
            }
          }, false)

          td.addEventListener('click', function(ev){
            this.toggleColor()
          }, false)
      }
    }
    /* END HOLDING FEATURE */

    var milkyWay = document.createElement('div')
    milkyWay.appendChild(this.table)
    document.body.appendChild(milkyWay)
  }

  this.generate = function(){

    // reset population counter for this generation
    this.populationCount = 0

    for (var a=0; a < this.tbody.rows.length; a++) {

      for (var b=0; b < this.tbody.rows[a].cells.length; b++) {

        var cell = this.tbody.rows[a].cells[b]

        var x = cell.cellIndex,
            y = cell.parentNode.rowIndex

        var xOffset = this.tbody.rows[0].cells.length-1,
            yOffset = this.tbody.rows.length-1

        // Get the number of neighbours of the current cell.
        // Needed for applying the rules
        var neighboursCount = this.countNeighbours(x, y, xOffset, yOffset)

        // Apply the rules on the current cell
        this.applyRulesOn(cell, neighboursCount)

        // log population for this generation
        if (cell.isAlive()) this.populationCount++
      }
    }
  }

  this.applyRulesOn = function(cell, neighboursCount){
    /* RULES BEGIN */
    if (cell.isAlive()) {

      if (neighboursCount < 2 || neighboursCount > 3) {
        cell.className = 'dead'
      } else {
        cell.className = 'alive'
      }
    } else { // cell is dead

      if (neighboursCount == 3) {
        cell.className = 'alive'
      }
    }
    /* RULES END */    
  }

  this.spawn = function(name, x, y){

    if (x < 0 || y < 0) return false

    var shape = []

    // define shape by name
    if (name == 'glider') shape = [[2,1], [3,2], [3,3], [2,3], [1,3]]

    // draw shape
    for (s=0; s < shape.length; s++) {
      var cellIndex = shape[s][0]+y-2
      var rowIndex = shape[s][1]+x-2
      this.tbody.rows[rowIndex].cells[cellIndex].live()
    }
  }

  this.renderNextGeneration = function(){

    for (var c=0; c < this.tbody.rows.length; c++) {

      for (var d=0; d < this.tbody.rows[c].cells.length; d++) {

        var nextCell = this.tbody.rows[c].cells[d]
        if (nextCell.className == 'alive') {
          nextCell.style.backgroundColor = ALIVE
        } else {
          nextCell.style.backgroundColor = DEAD
        }
        nextCell.removeAttribute('class')
      }
    }

    this.generationCount++
  }

  // This function is CPU intensive and should be refactored.
  // Maybe a better way to do this is by using Vector2D
  this.countNeighbours = function(x, y, xOffset, yOffset){

    var top = (y <= 0) ? null :
    this.tbody.rows[y-1].cells[x]

    ,   right = (x >= xOffset) ? null :
    this.tbody.rows[y].cells[x+1]

    ,   bottom = (y >= yOffset) ? null :
    this.tbody.rows[y+1].cells[x]   

    ,   left = (x <= 0) ? null :
    this.tbody.rows[y].cells[x-1]

    ,   top_left = (y <= 0 || x <= 0) ? null :
    this.tbody.rows[y-1].cells[x-1]

    ,   top_right = (y <= 0 || x >= xOffset) ? null :
    this.tbody.rows[y-1].cells[x+1]

    ,   bottom_left = (y >= yOffset || x <= 0) ? null :
    this.tbody.rows[y+1].cells[x-1]

    ,   bottom_right = (y >= yOffset || x >= xOffset) ? null :
    this.tbody.rows[y+1].cells[x+1]

    var neighboursCount = 0

    if (top          && top.isAlive())          neighboursCount++
    if (right        && right.isAlive())        neighboursCount++
    if (bottom       && bottom.isAlive())       neighboursCount++
    if (left         && left.isAlive())         neighboursCount++
    if (top_left     && top_left.isAlive())     neighboursCount++
    if (top_right    && top_right.isAlive())    neighboursCount++
    if (bottom_left  && bottom_left.isAlive())  neighboursCount++
    if (bottom_right && bottom_right.isAlive()) neighboursCount++

    return neighboursCount
  }

} // end of World
