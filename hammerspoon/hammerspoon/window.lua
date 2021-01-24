--- start move cursor bewteen screens
function move_cursor()
    return function()
        local screen = hs.mouse.getCurrentScreen()
        local nextScreen = screen:next()
        local rect = nextScreen:fullFrame()
        -- get the center of the rect
        local center = hs.geometry.rect(rect).center
        hs.mouse.setAbsolutePosition(center)
    end
end

-- Cycle through mouse cursor
hs.hotkey.bind({'cmd', 'ctrl', 'shift'}, "Pagedown", move_cursor())

-- Window Resizing helper
function resizeWindow(mod, key, cb)
    hs.hotkey.bind(mod, key, function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f = cb(f, max)
        win:setFrame(f, 0)
    end)
end

-- Center
resizeWindow({'cmd', 'ctrl', 'shift'}, 'Pageup', function(f, max)
    f.x = max.x + (max.w / 2) - (f.w / 2)
    f.y = max.y + (max.h / 2) - (f.h / 2)
    return f
end)

-- Maximize
resizeWindow({'cmd', 'ctrl', 'shift'}, 'Down', function(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    return f
end)

-- Left
resizeWindow({'cmd', 'ctrl', 'shift'}, 'Left', function(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    return f
end)

-- Right
resizeWindow({'cmd', 'ctrl', 'shift'}, 'Right', function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    return f
end)

-- Cycle through the screens
hs.hotkey.bind({'cmd', 'ctrl', 'shift'}, 'Up', function()
    local nextScreen = hs.screen.mainScreen():next()
    local win = hs.window.focusedWindow()
    win:moveToScreen(nextScreen, 0)
    win:centerOnScreen(0)
end)

-- Top Right
resizeWindow({'cmd', 'ctrl', 'shift', 'alt'}, 'Up', function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    return f
end)

-- Top Left
resizeWindow({'cmd', 'ctrl', 'shift', 'alt'}, 'Left', function(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    return f
end)

-- Bottom Right
resizeWindow({'cmd', 'ctrl', 'shift', 'alt'}, 'Right', function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    return f
end)

-- Bottom Left
resizeWindow({'cmd', 'ctrl', 'shift', 'alt'}, 'Down', function(f, max)
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    return f
end)
