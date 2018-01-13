'
' This reader will make network requests to Quizlet, cache the result and form an object intended for a LabelList to read
'
sub init()
    m.top.functionName = "taskRunner"
end sub

sub taskRunner()
    'Use cached user if we have it, otherwise get the user and cache it
    if m.global.hasField("userContentJson")
        json = m.global.userContentJson
    else
        readInternet = createObject("roUrlTransfer")
        readInternet.setUrl("https://api.quizlet.com/2.0/users/ackmanx?client_id=DWWK8n2dW9")

        'Quizlet uses HTTPS only, so must load a certificate bundle and hope it includes the CA that Quizlet signs with
        'This bundle comes with Roku by default so it isn't stored anywhere in the codebase
        readInternet.setCertificatesFile("common:/certs/ca-bundle.crt")

        'Make a GET request
        json = ParseJSON(readInternet.getToString())

        'Cache JSON results. This component is destroyed after being used so the cache has to live in the global object
        setGlobal("userContentJson", json)
    end if

    'LabelList must have a ContentNode container as child, which will house the items on the list
    contentNodeContainer = CreateObject("roSGNode", "ContentNode")

    'Build the child ContentNodes for the LabelList to use
    for each set in json.sets
        setItem = contentNodeContainer.createChild("ContentNode")
        setItem.title = set.title
        setItem.id = set.id.toStr()
    end for

    m.top.content = contentNodeContainer
end sub
