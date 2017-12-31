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

    contentNodeContainer = CreateObject("roSGNode", "ContentNode")

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
    setId = m.setList.content.getChild(m.setList.itemSelected).id
    'This is the only way to put an item on the global object. You can access it later via m.global.setId
    m.global.addFields({setId: setId})
    
    m.top.createChild("QuizletSet")
end sub
