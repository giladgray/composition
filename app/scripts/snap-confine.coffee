Snap.plugin (Snap, Element, Paper, global) ->
    clamp = (value, min, max) -> Math.min(max, Math.max(min, value))

    # type-independent coordinate getters
    Element.prototype.x    = -> @asPX('x') or @asPX('cx') or 0 # soak up NaNs
    Element.prototype.y    = -> @asPX('y') or @asPX('cy') or 0
    Element.prototype.size = -> @asPX('r') or @asPX('width') or 0

    Element.prototype.confineDrag = (width, height) ->
        # reposition and clamp to composition bounds (circle is radius-based)
        clampToBounds = (x, y, size) =>
            # default to current values
            x ?= @x()
            y ?= @y()
            size ?= @size()

            if @type is 'circle'
                @attr cx: clamp(x, size, width - size), cy: clamp(y, size, height - size)
            else
                @attr x: clamp(x, 0, width - size), y: clamp(y, 0, height - size)

        prepMove = (x, y, evt) ->
            @attr opacity: 0.7
            # store initial state for rect or circle
            @data 'sx', x = evt.offsetX - @x()
            @data 'sy', y = evt.offsetY - @y()

        move = (dx, dy, x, y, evt) ->
            return unless evt.target is @paper.node or evt.target.parentNode is @paper.node
            # only drag if not resizing
            unless evt.metaKey
                clampToBounds(evt.offsetX - @data('sx'), evt.offsetY - @data('sy'))

        endMove = (evt) ->
            @attr opacity: 1
            # delete if dragged to trash
            @remove() if 'trash' in evt.target.classList
            clampToBounds()

        @drag move, prepMove, endMove
