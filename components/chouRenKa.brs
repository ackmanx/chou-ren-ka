sub init()
    m.top.backgroundUri = ""
    m.top.backgroundColor="0x396B77FF"

    'Start the app with showing the set list screen
    QuizletSetList = m.top.createChild("QuizletSetList")

    'Register an event listener on my LabelList to detect when user presses OK
    'LabelList will automatically handle OK remote presses and populate index of the list in this field
    m.setList = QuizletSetList.findNode("LabelListID")
    m.setList.observeField("itemSelected", "QuizletSetList_openSet")
end sub

sub QuizletSetList_openSet()
    setId = m.setList.content.getChild(m.setList.itemSelected).id

    'I don't know how to pass an argument to CreateObject, so throw the setId on the global object
    setGlobal("setId", setId)

    'Create new screen to show our set and remove set list screen
    quizletSet = CreateObject("roSGNode", "QuizletSet")
    m.top.replaceChild(quizletSet, 0)

    'Remote focus cannot be set until after the component is mounted
    'Note even though QuizletSet sets focus on init, Roku don't care and ignores it
    quizletSet.setFocus(true)
end sub

'm.global sucks and has to be set up explicitly with new fields to work
sub setGlobal(key as String, value as Object)
    if m.global.hasField(key)
        m.global[key] = value
    else
        fields = {}
        fields[key] = value
        m.global.addFields(fields)
    end if
end sub
