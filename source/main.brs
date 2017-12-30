sub Main()
    print "Main.brs > Application started!"

    'Required boilerplate code from Roku docs
    'Indicate this is a Roku SceneGraph application
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    ' screen.CreateScene("QuizletSetList")
    ' screen.show()

    'Some type of event handling is defined here
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)

        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
