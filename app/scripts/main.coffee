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
$('.add.circle').click -> new Circle()
$('.add.square').click -> new Square()

$('.btn.new').click -> snap.clear()
$('.btn.save').click -> console.log snap.toString()
$('.btn.trash').click -> Snap.selected()?.remove()

# TODO: make use of selectable() - key bindings for nudgine
