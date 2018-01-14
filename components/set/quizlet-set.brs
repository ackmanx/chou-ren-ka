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

    m.currentSideLabel = m.top.findNode("currentSide")
    m.currentSideLabel.text = m.currentSide
    'In order to set font size without specifying a font file, you must set a "font" attribute in XML with a system font, and then set font size in BrightScript
    m.currentSideLabel.font.size = 48

    m.currentIndexLabel = m.top.findNode("currentIndex")
    m.currentIndexLabel.text = getCurrentIndexLabel()
    'In order to set font size without specifying a font file, you must set a "font" attribute in XML with a system font, and then set font size in BrightScript
    m.currentIndexLabel.font.size = 48
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
    m.currentIndexLabel.text = getCurrentIndexLabel()
    m.currentSide = "term"
end sub

sub nextTerm()
    m.currentIndex++

    if m.currentIndex = m.json.terms.count() then
        m.currentIndex = 0
    end if

    m.card.text = m.json.terms[m.currentIndex].term
    m.currentIndexLabel.text = getCurrentIndexLabel()
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

    m.currentSideLabel.text = m.currentSide
end sub


'--------------------------------------------------------------------------------------------------------------------------------
' Utility and Whatnot functions
'--------------------------------------------------------------------------------------------------------------------------------

function getCurrentIndexLabel() as String
    return (m.currentIndex + 1).toStr() + " / " + m.json.terms.count().toStr()
end function

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
