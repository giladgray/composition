Snap.plugin (Snap, Element, Paper, global) ->
    Element.prototype.resize = (min, max) ->
        startResize = (x, y, evt) ->
            # save original location for resizing
            @data 'start', @getBBox()
            # save starting location within parent container
            @data 'sx', evt.offsetX - @asPX('cx')
            @data 'sy', evt.offsetY - @asPX('cy')

        resize = (dx, dy, x, y, evt) ->
            return unless evt.target is @paper.node or evt.target.parentNode is @paper.node
            # resize or drag
            if evt.metaKey
                newSize = Math.max(@data('start').height + dx, min ? 0)
                if max? then newSize = Math.min(max, newSize)
                switch @type
                    when 'circle' then @attr 'r', newSize / 2
                    when 'rect' then @attr width: newSize, height: newSize

        @drag resize, startResize
