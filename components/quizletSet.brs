sub init()
    jsonString = ReadAsciiFile("pkg:/mockJson/set-directional-stuff.json")
    m.json = ParseJSON(jsonString)

    m.currentIndex = 0
    m.currentSide = "term"

    m.cardText = m.top.findNode("cardText")
    m.cardText.text = m.json.terms[0].term

    m.top.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then
        if key = "OK" THEN
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

sub previousTerm()
    m.currentIndex--

    if m.currentIndex = -1 then
        m.currentIndex = m.json.terms.count() - 1
    end if

    m.cardText.text = m.json.terms[m.currentIndex].term
    m.currentSide = "term"
end sub

sub nextTerm()
    m.currentIndex++

    if m.currentIndex = m.json.terms.count() then
        m.currentIndex = 0
    end if

    m.cardText.text = m.json.terms[m.currentIndex].term
    m.currentSide = "term"
end sub

sub flipCard()
    if m.currentSide = "term" then
        m.cardText.text = m.json.terms[m.currentIndex].definition
        m.currentSide = "definition"
    else
        m.cardText.text = m.json.terms[m.currentIndex].term
        m.currentSide = "term"
    end if
end sub
