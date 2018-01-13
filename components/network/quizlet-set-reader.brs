sub init()
    m.top.functionName = "taskRunner"
end sub

sub taskRunner()
    readInternet = createObject("roUrlTransfer")
    readInternet.setUrl("https://api.quizlet.com/2.0/sets/" + m.global.setId.toStr() + "?client_id=DWWK8n2dW9")

    'Quizlet uses HTTPS only, so must load a certificate bundle and hope it includes the CA that Quizlet signs with
    readInternet.setCertificatesFile("common:/certs/ca-bundle.crt")

    'Make a GET request
    m.top.content = ParseJSON(readInternet.getToString())
end sub
