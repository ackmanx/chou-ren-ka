sub init()
    'Create component scope references
    m.setList = m.top.findNode("LabelListID")

    populateSetList()
    centerSetList()

    m.top.setFocus(true)
end sub

sub populateSetList()
    jsonString = ReadAsciiFile("pkg:/mockJson/user-ackmanx.json")
    m.json = ParseJSON(jsonString)

    'LabelList must have a ContentNode container as child, which will house the items on the list
    contentNodeContainer = CreateObject("roSGNode", "ContentNode")

    for each set in m.json.sets
        setItem = contentNodeContainer.createChild("ContentNode")
        setItem.title = set.title
        setItem.id = set.id.toStr()
    end for

    'LabelList has a content field declared by default, so we can access it
    m.setList.content = contentNodeContainer
end sub

sub centerSetList()
    'LabelLists don't have width/height, but they have a boundingRect, which do, so we can use this to measure it
    boundingRect = m.setList.boundingRect()
    x = (1920 - boundingRect.width) / 2
    y = (1080 - boundingRect.height) / 2
    m.setList.translation = [ x, y ]
end sub
