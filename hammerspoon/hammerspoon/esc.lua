targetKeyCode = 62
otherKeyDetected = false

handler = function(evt)
    local flagged = evt:getFlags()["ctrl"]
    local keyCode = evt:getProperty(hs.eventtap.event.properties
                                        .keyboardEventKeycode)
    -- print("change: ", flagged, keyCode)

    -- if press another key while pressing ctrl
    if flagged and keyCode ~= targetKeyCode then
        -- print('prevent sending escape')
        otherKeyDetected = true
    end

    -- if leaving ctrl key
    if not flagged and keyCode == targetKeyCode then

        if not otherKeyDetected then
            -- print('send esc')
            return true, {
                hs.eventtap.event.newKeyEvent({}, 'escape', true),
                hs.eventtap.event.newKeyEvent({}, 'escape', false)
            }
        end

        otherKeyDetected = false
    end

    return false
end

tap = hs.eventtap.new({
    hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged
}, handler)
tap:start()
