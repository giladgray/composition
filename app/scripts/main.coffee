console.log '\'Allo \'Allo!'

COLOR = '#fff'
w = 400
h = 600

Math.clamp = (value, min, max) ->
    Math.min(max, Math.max(min, value))

Circle =
    radius: 50

    create: (snap) ->
        snap.circle w / 2, h / 2, @radius
            .attr fill: COLOR
            .drag @resize, @prepResize, @endResize

    prepResize: (x, y, evt) ->
        # save original radius for resizing
        @data 'r',  @asPX('r')
        @data 'sx', evt.offsetX - @asPX('cx')
        @data 'sy', evt.offsetY - @asPX('cy')

    resize: (dx, dy, x, y, evt) ->
        # resize or drag
        if evt.metaKey
            @attr 'r', Math.clamp(@data('r') + dx, 5, w / 2)
        else
            # TODO: if within bounds
            @attr
                cx: evt.offsetX - @data('sx')
                cy: evt.offsetY - @data('sy')
        # clamp to composition bounds
        r = @asPX 'r'
        @attr
            cx: Math.clamp @asPX('cx'), r, w - r
            cy: Math.clamp @asPX('cy'), r, h - r

    endResize: (evt) ->

Square =
    size: 50
    create: (snap) ->
        snap.rect w / 2 - @size, h / 2 - @size, @size, @size
            .attr fill: '#fff'
            .drag @resize, @prepResize, @endResize

    prepResize: (x, y, evt) ->
        @data 'size', @asPX('width')
        @data 'sx', evt.offsetX - @asPX('x')
        @data 'sy', evt.offsetY - @asPX('y')

    resize: (dx, dy, x, y, evt) ->
        # resize or drag
        size = @data('size')
        if evt.metaKey
            size = Math.clamp(size + dx, 5, w)
            @attr
                width: size
                height: size
        else
            @attr
                x: evt.offsetX - @data('sx')
                y: evt.offsetY - @data('sy')
        # clamp to composition bounds
        @attr
            x: Math.clamp @asPX('x'), 0, w - size
            y: Math.clamp @asPX('y'), 0, h - size

    endResize: (evt) ->

snap = Snap('#composition')

$('.add.circle').click -> Circle.create(snap)
$('.add.square').click -> Square.create(snap)
