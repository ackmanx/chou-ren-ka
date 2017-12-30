sub init()
    jsonString = ReadAsciiFile("pkg:/mockJson/user-ackmanx.json")
    m.json = ParseJSON(jsonString)

    contentNodeContainer = m.top.createChild("ContentNode")

    for each set in m.json.sets
        setItem = contentNodeContainer.createChild("ContentNode")
        setItem.title = set.title
    end for

    m.top.findNode("setList-LabelList").content = contentNodeContainer
    m.top.setFocus(true)
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
