targetKeyCode = hs.keycodes.map.rightctrl -- ctrl
otherKeyDetected = false

handler = function(evt)
    local flagged = evt:getFlags()["ctrl"]
    local keyCode = evt:getProperty(hs.eventtap.event.properties
                                        .keyboardEventKeycode)
    -- print(targetKeyCode, keyCode, flagged, otherKeyDetected)

    -- if another key is pressed while holding ctrl
    if flagged and keyCode ~= targetKeyCode then otherKeyDetected = true end

    -- if ctrl key is released
    if not flagged and keyCode == targetKeyCode then
        -- and other keys has not been pressed while holding ctrl
        -- then act as escape
        if not otherKeyDetected then
            otherKeyDetected = false
            return true, {
                hs.eventtap.event.newKeyEvent('escape', true),
                hs.eventtap.event.newKeyEvent('escape', false),
                hs.eventtap.event.newKeyEvent(targetKeyCode, true) -- mitigate a glitch on iTerm2
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
