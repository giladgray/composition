Snap.plugin (Snap, Element, Paper, global) ->
    Element.prototype.resize = (min, max) ->
        isResize = false

        startResize = (dx, dy) =>
            isResize = true
            # save original location for resizing
            @data 'start', @getBBox()
            @data 'dx', dx

        resize = (dx, dy, x, y, evt) ->
            return unless evt.target is @paper.node or evt.target.parentNode is @paper.node
            # resize or drag
            if evt.metaKey
                unless isResize then startResize(dx, dy)
                newSize = Math.max(@data('start').height + dx - @data('dx'), min ? 0)
                if max? then newSize = Math.min(max, newSize)
                switch @type
                    when 'circle' then @attr 'r', newSize / 2
                    when 'rect'   then @attr width: newSize, height: newSize

        @drag resize, -> isResize = false
