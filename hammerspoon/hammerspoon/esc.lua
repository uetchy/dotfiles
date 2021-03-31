targetKeyCode = hs.keycodes.map.rightctrl -- map caps lock to ctrl in System Preferences
otherKeyDetected = false

keyboardHandler = function(evt)
    local flagged = evt:getFlags()["ctrl"]
    local keyCode = evt:getProperty(hs.eventtap.event.properties
                                        .keyboardEventKeycode)

    -- if another key is pressed while holding ctrl
    if flagged and keyCode ~= targetKeyCode then otherKeyDetected = true end

    -- if ctrl key is released
    if not flagged and keyCode == targetKeyCode then
        -- and other keys have not been pressed while holding ctrl
        -- then act as escape
        if not otherKeyDetected then
            otherKeyDetected = false
            return true, {
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.escape, true),
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.escape, false),
                hs.eventtap.event.newKeyEvent(targetKeyCode, false)
            }
        end

        -- reset flags
        otherKeyDetected = false
    end

    return false
end

keyboardTap = hs.eventtap.new({
    hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown,
    hs.eventtap.event.types.leftMouseDown
}, keyboardHandler)

keyboardTap:start()
