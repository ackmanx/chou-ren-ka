sub init()
    'Create component scope references
    m.labelList = m.top.findNode("LabelListID")

    'Run reader job to do network request to Quizlet for the set currently defined in m.global.setId
    startQuizletReaderTask()
end sub

sub startQuizletReaderTask()
    m.quizletUserReader = createObject("roSGNode", "QuizletUserReader")
    m.quizletUserReader.observeField("content", "populateSetList")
    m.quizletUserReader.control = "RUN"
end sub

sub populateSetList()
    'LabelList has a content field declared by default, so we can access it
    'Set our content to point to the newly-populated content from our QuizletReader
    m.labelList.content = m.quizletUserReader.content

    centerSetList()
end sub

sub centerSetList()
    'LabelLists don't have width/height, but they have a boundingRect, which do, so we can use this to measure it
    boundingRect = m.labelList.boundingRect()
    x = (1920 - boundingRect.width) / 2
    y = (1080 - boundingRect.height) / 2
    m.labelList.translation = [ x, y ]
end sub

'There's no onKeyEvent override here because LabelList has built-in handlers for key events
