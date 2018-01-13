sub init()
    m.top.backgroundUri = ""
    m.top.backgroundColor="0x396B77FF"

    'Start the app with showing the set list screen
    showSetList()
end sub


'--------------------------------------------------------------------------------------------------------------------------------
' Screen management functions
'--------------------------------------------------------------------------------------------------------------------------------

sub showSetList()
    quizletSetList = CreateObject("roSGNode", "QuizletSetList")

    'Our listener below has to be attached to the LabelList, not the entire component
    m.labelList = quizletSetList.findNode("LabelListID")

    'Register an event listener on my LabelList to detect when user presses OK
    'LabelList will automatically handle OK remote presses and populate index of the list in this field
    m.labelList.observeField("itemSelected", "openSet")

    'We should never have more than one child on our master component, so this is okay
    'The reason I don't do replaceChild here is because on application load our master component has no child to replace yet
    m.top.removeChildIndex(0)
    m.top.insertChild(quizletSetList, 0)

    'Remote focus cannot be set until after the component is mounted
    quizletSetList.setFocus(true)
end sub

sub openSet()
    'Our LabelList has a content child, which contains other content nodes for the list items
    setId = m.labelList.content.getChild(m.labelList.itemSelected).id

    'I don't know how to pass an argument to CreateObject, so throw the setId on the global object
    setGlobal("setId", setId)

    'Create new screen to show our set and remove set list screen
    quizletSet = CreateObject("roSGNode", "QuizletSet")

    m.top.replaceChild(quizletSet, 0)

    'Remote focus cannot be set until after the component is mounted
    quizletSet.setFocus(true)
end sub


'--------------------------------------------------------------------------------------------------------------------------------
' Utility and Whatnot functions
'--------------------------------------------------------------------------------------------------------------------------------

'Roku lets you listen to remote events in a component if you implement this function
function onKeyEvent(key as String, press as Boolean) as Boolean
    if press and key = "back" then
        'If user is at the set list, then back exits the application
        'This is because we return false to signify we aren't handling this event and Roku's native handler will be invoked
        if m.top.getChild(0).name = "QuizletSetList" then
            return false
        end if

        'If here, user must have pressed back on the set screen, so show the set list screen now
        showSetList()
        return true
    end if

    return false
end function
