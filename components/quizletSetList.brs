sub init()
    'Create component scope references
    m.setList = m.top.findNode("setList-LabelList")

    populateSetList()
    centerSetList()

    m.top.setFocus(true)
end sub

sub populateSetList()
    jsonString = ReadAsciiFile("pkg:/mockJson/user-ackmanx.json")
    json = ParseJSON(jsonString)

    contentNodeContainer = createObject("RoSGNode", "ContentNode")

    for each set in json.sets
        setItem = contentNodeContainer.createChild("ContentNode")
        setItem.title = set.title
    end for

    m.setList.content = contentNodeContainer
end sub

sub centerSetList()
    'LabelLists don't have width/height, but they have a boundingRect, which does
    boundingRect = m.setList.boundingRect()
    x = (1920 - boundingRect.width) / 2
    y = (1080 - boundingRect.height) / 2
    m.setList.translation = [ x, y ]
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then
        if key = "OK" THEN
            print "OK pressed"
            return true
        end if
    end if

    return false
end function
