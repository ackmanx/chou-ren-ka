'm.global sucks and has to add new fields explicitly or it will fail
sub setGlobal(key as String, value as Object)
    if m.global.hasField(key)
        m.global[key] = value
    else
        fields = {}
        fields[key] = value
        m.global.addFields(fields)
    end if
end sub
