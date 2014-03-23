Snap.plugin (Snap, Element, Paper, global) ->
    global.selected = null

    select = (element) ->
        # revert styles on previously selected element
        global.selected?.attr opacity: 1
        global.selected?.paper?.node.classList.remove('selected')
        # update selected to new element
        global.selected = element
        global.selected?.attr opacity: 0.7
        global.selected?.paper.node.classList.add('selected')

    # get or set the selected element
    Snap.selected = (element) ->
        if element isnt undefined then select element else return global.selected

    # click on element to toggle selected
    Element.prototype.selectable = ->
        @click ->
            if global.selected is @ then select() else select(@)
