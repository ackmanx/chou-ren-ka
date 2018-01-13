sub init()
    m.top.functionName = "taskRunner"
end sub

sub taskRunner()
    readInternet = createObject("roUrlTransfer")
    readInternet.setUrl("https://api.quizlet.com/2.0/users/ackmanx?client_id=DWWK8n2dW9")

    'Quizlet uses HTTPS only, so must load a certificate bundle and hope it includes the CA that Quizlet signs with
    readInternet.setCertificatesFile("common:/certs/ca-bundle.crt")

    'Make a GET request
    json = ParseJSON(readInternet.getToString())

    'LabelList must have a ContentNode container as child, which will house the items on the list
    contentNodeContainer = CreateObject("roSGNode", "ContentNode")

    for each set in json.sets
        setItem = contentNodeContainer.createChild("ContentNode")
        setItem.title = set.title
        setItem.id = set.id.toStr()
    end for

    m.top.content = contentNodeContainer
end sub
