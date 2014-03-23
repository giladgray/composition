Snap.plugin (Snap, Element, Paper, global) ->
    clamp = (value, min, max) -> Math.min(max, Math.max(min, value))

    Element.prototype.confineDrag = (width, height) ->
        prepMove = (x, y, evt) ->
            @attr opacity: 0.7
            # store initial state for rect or circle
            @data 'size', @asPX('width') or @asPX('r')
            @data 'sx', x = evt.offsetX - (@asPX('x') or @asPX('cx')) or 0 # soak up NaNs
            @data 'sy', y = evt.offsetY - (@asPX('y') or @asPX('cy')) or 0

        move = (dx, dy, x, y, evt) ->
            return unless evt.target is @paper.node or evt.target.parentNode is @paper.node
            # only drag if not resizing
            size = @data('size')
            unless evt.metaKey
                x = evt.offsetX - @data('sx')
                y = evt.offsetY - @data('sy')
            # clamp to composition bounds (circle is radius-based)
            if @type is 'circle'
                @attr cx: clamp(x, size, width - size), cy: clamp(y, size, height - size)
            else
                @attr x: clamp(x, 0, width - size), y: clamp(y, 0, height - size)

        endMove = (evt) ->
            @attr opacity: 1
            # delete if dragged to trash
            @remove() if 'trash' in evt.target.classList

        @drag move, prepMove, endMove
