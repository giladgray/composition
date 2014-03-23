console.log '\'Allo \'Allo!'

### INITIALIZE SNAP ###
snap   = Snap('#composition')
width  = snap.node.clientWidth
height = snap.node.clientHeight

### DEFINE SHAPES ###
class Shape
    color: '#fff'
    constructor: (elem) ->
        throw new Error("Must create Element") unless elem
        elem.attr fill: @color
            .resize(5, width)
            .confineDrag(width, height)
            .selectable()

class Circle extends Shape
    radius: 25
    constructor: ->
        super snap.circle width / 2, height / 2, @radius

class Square extends Shape
    size: 50
    constructor: ->
        super snap.rect (width - @size) / 2, (height - @size) / 2, @size, @size

### BIND EVENTS ###
click = (selector, fn) ->
    document.getElementsByClassName(selector)?[0].onclick = fn

click 'add circle', -> new Circle()
click 'add square', -> new Square()

click 'btn new', -> snap.clear()
click 'btn save', -> console.log snap.toString()
click 'btn trash', ->
    Snap.selected()?.remove()
    Snap.selected(null)
    snap.node.classList.remove('selected')

# TODO: make use of selectable() - key bindings for nudging
