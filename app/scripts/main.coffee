console.log '\'Allo \'Allo!'

COLOR = '#fff'
w = 400
h = 600

Circle =
    radius: 25
    create: (snap) ->
        snap.circle w / 2, h / 2, @radius
            .attr fill: COLOR
            .resize(5, w)
            .confineDrag(w, h)

Square =
    size: 50
    create: (snap) ->
        snap.rect (w - @size) / 2, (h - @size) / 2, @size, @size
            .attr fill: COLOR
            .resize(5, w)
            .confineDrag w, h

snap = Snap('#composition')

$('.add.circle').click -> Circle.create(snap)
$('.add.square').click -> Square.create(snap)

$('.btn.new').click -> snap.clear()
$('.btn.save').click -> console.log snap.toString()
