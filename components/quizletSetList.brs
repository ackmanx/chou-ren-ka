sub init()
    'Create component scope references
    m.setList = m.top.findNode("LabelListID")

    startQuizletReaderTask()
    populateSetList()
    centerSetList()

    m.top.setFocus(true)
end sub

sub startQuizletReaderTask()
    m.quizletUserReader = createObject("roSGNode", "QuizletUserReader")
    m.quizletUserReader.observeField("content", "populateSetList")
    m.quizletUserReader.control = "RUN"
end sub

sub populateSetList()
    'LabelList has a content field declared by default, so we can access it
    'Set our content to point to the newly-populated content from our QuizletReader
    m.setList.content = m.quizletUserReader.content
end sub

sub centerSetList()
    'LabelLists don't have width/height, but they have a boundingRect, which do, so we can use this to measure it
    boundingRect = m.setList.boundingRect()
    x = (1920 - boundingRect.width) / 2
    y = (1080 - boundingRect.height) / 2
    m.setList.translation = [ x, y ]
end sub
