local FinderWF = hs.window.filter.new("Finder")

-- Finder sort by Name
local sortByName = hs.hotkey.new({'cmd', 'shift'}, '1', nil, function()
    hs.eventtap.keyStroke({'cmd', 'ctrl', 'alt'}, '1')
end)

-- Finder sort by date
local sortByDate = hs.hotkey.new({'cmd', 'shift'}, '2', nil, function()
    hs.eventtap.keyStroke({'cmd', 'ctrl', 'alt'}, '5')
end)

FinderWF:subscribe(hs.window.filter.windowFocused, function()
    sortByName:enable()
    sortByDate:enable()
end):subscribe(hs.window.filter.windowUnfocused, function()
    sortByName:disable()
    sortByDate:disable()
end)
