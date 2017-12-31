sub init()
    'Create component scope references
    m.setList = m.top.findNode("setList-LabelList")

    populateSetList()
    centerSetList()

    m.setList.observeField("itemSelected", "openSetHandler")

    m.top.setFocus(true)
end sub

sub populateSetList()
    jsonString = ReadAsciiFile("pkg:/mockJson/user-ackmanx.json")
    m.json = ParseJSON(jsonString)

    contentNodeContainer = CreateObject("RoSGNode", "ContentNode")

    for each set in m.json.sets
        setItem = contentNodeContainer.createChild("ContentNode")
        setItem.title = set.title
        setItem.id = set.id.toStr()
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

sub openSetHandler()
    'todo: open new screen now that I have the setId. For this mock data example, ignore the id and just show cards with static mock data
    setId = m.setList.content.getChild(m.setList.itemSelected).id
end sub
