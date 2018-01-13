sub init()
    'Run reader job to do network request to Quizlet for the set currently defined in m.global.setId
    startQuizletReaderTask()
end sub

sub startQuizletReaderTask()
    m.quizletUserReader = createObject("roSGNode", "QuizletSetReader")
    m.quizletUserReader.observeField("content", "populateSet")
    m.quizletUserReader.control = "RUN"
end sub

sub populateSet()
    'Reader's content field will be the result of the Quizlet API call
    m.json = m.quizletUserReader.content

    m.currentIndex = 0
    m.currentSide = "term"

    m.card = m.top.findNode("card")
    m.card.text = m.json.terms[0].term
end sub


'--------------------------------------------------------------------------------------------------------------------------------
' Card Flipping functions
'--------------------------------------------------------------------------------------------------------------------------------

sub previousTerm()
    m.currentIndex--

    if m.currentIndex = -1 then
        m.currentIndex = m.json.terms.count() - 1
    end if

    m.card.text = m.json.terms[m.currentIndex].term
    m.currentSide = "term"
end sub

sub nextTerm()
    m.currentIndex++

    if m.currentIndex = m.json.terms.count() then
        m.currentIndex = 0
    end if

    m.card.text = m.json.terms[m.currentIndex].term
    m.currentSide = "term"
end sub

sub flipCard()
    if m.currentSide = "term" then
        m.card.text = m.json.terms[m.currentIndex].definition
        m.currentSide = "definition"
    else
        m.card.text = m.json.terms[m.currentIndex].term
        m.currentSide = "term"
    end if
end sub


'--------------------------------------------------------------------------------------------------------------------------------
' Utility and Whatnot functions
'--------------------------------------------------------------------------------------------------------------------------------

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then
        if key = "OK" then
            flipCard()
            return true
        else if key = "right" then
            nextTerm()
            return true
        else if key = "left" then
            previousTerm()
            return true
        end if
    end if

    return false
end function
