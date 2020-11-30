targetKeyCode = 62
otherKeyDetected = false

handler = function(evt)
    local flagged = evt:getFlags()["ctrl"]
    local keyCode = evt:getProperty(hs.eventtap.event.properties
                                        .keyboardEventKeycode)

    -- if another key is pressed while holding ctrl
    if flagged and keyCode ~= targetKeyCode then otherKeyDetected = true end

    -- if ctrl key is released
    if not flagged and keyCode == targetKeyCode then
        -- act as escape
        if not otherKeyDetected then
            return true, {
                hs.eventtap.event.newKeyEvent({}, 'escape', true),
                hs.eventtap.event.newKeyEvent({}, 'escape', false)
            }
        end

        -- reset flags
        otherKeyDetected = false
    end

    return false
end

tap = hs.eventtap.new({
    hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged
}, handler)
tap:start()
