-- Finder sort by Name
local sortByName = hs.hotkey.new({'cmd', 'shift'}, '1', nil, function()
    hs.eventtap.keyStroke({'cmd', 'ctrl', 'alt'}, '1')
end)

-- Finder sort by date
local sortByDate = hs.hotkey.new({'cmd', 'shift'}, '2', nil, function()
    hs.eventtap.keyStroke({'cmd', 'ctrl', 'alt'}, '5')
end)

function enableAll()
    sortByName:enable()
    sortByDate:enable()
end

function disableAll()
    sortByName:disable()
    sortByDate:disable()
end

local FinderWF = hs.window.filter.new("Finder")
FinderWF:subscribe(hs.window.filter.windowFocused, enableAll):subscribe(
    hs.window.filter.windowUnfocused, disableAll)
