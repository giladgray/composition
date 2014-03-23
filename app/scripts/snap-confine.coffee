Snap.plugin (Snap, Element, Paper, global) ->
    clamp = (value, min, max) -> Math.min(max, Math.max(min, value))

    # update position agnostically for rect or circle
    Element.prototype.moveTo = (x, y) ->
        if @type is 'circle'
            @attr cx: x, cy: y
        else @attr {x, y}

    Element.prototype.confineDrag = (width, height) ->
        prepMove = (x, y, evt) ->
            @attr opacity: 0.7
            # store initial state for rect or circle
            @data 'size', @asPX('width') or @asPX('r')
            @data 'sx', evt.offsetX - (@asPX('x') or @asPX('cx'))
            @data 'sy', evt.offsetY - (@asPX('y') or @asPX('cy'))

        move = (dx, dy, x, y, evt) ->
            return unless evt.target is @paper.node or evt.target.parentNode is @paper.node
            # only drag if not resizing
            size = @data('size')
            unless evt.metaKey
                @moveTo evt.offsetX - @data('sx'), evt.offsetY - @data('sy')
            # clamp to composition bounds (circle is radius-based)
            if @type is 'circle'
                @moveTo clamp(@asPX('cx'), size, width - size), clamp(@asPX('cy'), size, height - size)
            else
                @moveTo clamp(@asPX('x'), 0, width - size), clamp(@asPX('y'), 0, height - size)

        endMove = (evt) ->
            @attr opacity: 1
            # delete if dragged to trash
            @remove() if 'trash' in evt.target.classList

        @drag move, prepMove, endMove
