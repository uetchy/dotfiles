targetKeyCode = hs.keycodes.map.rightctrl -- ctrl
otherKeyDetected = false
-- lastInvocation = 0

keyboardHandler = function(evt)
    local flagged = evt:getFlags()["ctrl"]
    local keyCode = evt:getProperty(hs.eventtap.event.properties
                                        .keyboardEventKeycode)
    -- local eventType = evt:getType()
    -- print('\ntype', eventType, '\nkeyCode', keyCode, '\nflagged?', flagged,
    --       '\notherKey?', otherKeyDetected)

    -- local now = hs.timer.secondsSinceEpoch()
    -- local diff = (now - lastInvocation) * 1000
    -- if not flagged then print(diff) end
    -- lastInvocation = now

    -- if another key is pressed while holding ctrl
    if flagged and keyCode ~= targetKeyCode then otherKeyDetected = true end

    -- if ctrl key is released
    if not flagged and keyCode == targetKeyCode then
        -- and other keys has not been pressed while holding ctrl
        -- then act as escape
        if not otherKeyDetected then
            otherKeyDetected = false
            return true, {
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.escape, true),
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.escape, false)
                -- hs.eventtap.event.newKeyEvent(targetKeyCode, false)
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

-- mitigate a glitch on iTerm2
local iTermWF = hs.window.filter.new("iTerm2")
iTermWF:subscribe(hs.window.filter.windowFocused,
                  function() keyboardTap:stop() end):subscribe(
    hs.window.filter.windowUnfocused, function() keyboardTap:start() end)
