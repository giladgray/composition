console.log '\'Allo \'Allo!'

w = 400
h = 600

Math.clamp = (value, min, max) ->
    Math.min(max, Math.max(min, value))

prepResize = ->
    # save original radius for resizing
    @data 'r',  @asPX('r')

resize = (dx, dy, x, y, evt) ->
    # resize or drag
    if evt.metaKey
        @attr 'r', Math.clamp(@data('r') + dx, 5, w / 2)
    else
        # TODO: if within bounds
        @attr cx: evt.offsetX, cy: evt.offsetY
    # clamp to composition bounds
    r = @asPX 'r'
    @attr
        cx: Math.clamp @asPX('cx'), r, w - r
        cy: Math.clamp @asPX('cy'), r, h - r

snap = Snap('#composition')
c = snap.circle w / 2, h / 2, 100
        .attr fill: '#fff'
        .drag resize, prepResize

window.circle = c
