Snap.plugin (Snap, Element, Paper, global) ->
    global.selected = null

    focusOn = (element) ->
        return if global.selected is element
        # revert styles on previously selected element
        global.selected?.attr opacity: 1
        global.selected?.paper?.node.classList.remove('selected')
        # update selected to new element
        global.selected = element
        global.selected?.attr opacity: 0.7
        global.selected?.paper.node.classList.add('selected')

    # get or set the selected element
    Snap.focus = (element) ->
        if _.isUndefined(element)   then return global.selected
        else if _.isString(element) then element = Snap.select element
        focusOn element
        return element

    # click on element to toggle selected
    Element.prototype.focusable = ->
        # clear selection when clicking on paper
        @paper.mousedown (evt) -> focusOn() unless evt.focused
        # select immediately on mousedown
        @mousedown (evt) ->
            evt.focused = true # disable deselect
            focusOn @

    Element.prototype.focus = -> Snap.selected @

