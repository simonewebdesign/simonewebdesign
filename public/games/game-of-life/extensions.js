var DEAD  = '',
    ALIVE = 'rgb(0, 255, 255)'

HTMLElement.prototype.live = function() {
  if (this.nodeName === 'TD') {
    if (this.style.backgroundColor == ALIVE) {
      // cell is already alive
      return false
    }
    this.style.backgroundColor = ALIVE
    return true
  }
}

HTMLElement.prototype.die = function() {
  if (this.nodeName === 'TD') {  
    if (this.style.backgroundColor == DEAD) {
      // cell is already dead
      return false
    }
    this.style.backgroundColor = DEAD
    return true
  }
}

HTMLElement.prototype.isAlive = function() {
  return (this.nodeName === 'TD') && (this.style.backgroundColor == ALIVE)
}

HTMLElement.prototype.toggleColor = function() {
  this.style.backgroundColor = this.style.backgroundColor == DEAD ? ALIVE : DEAD
}

