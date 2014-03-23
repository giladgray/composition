Snap.plugin (Snap, Element, Paper, global) ->
    global.selected = null

    select = (element) ->
        global.selected?.attr opacity: 1
        global.selected = element
        global.selected?.attr opacity: 0.7

    Snap.selected = (element) ->
        if element? then select element else return global.selected

    Element.prototype.selectable = ->
        @click ->
            if global.selected is @ then select() else select(@)
