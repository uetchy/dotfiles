-- Open Dictionary
hs.hotkey.bind({'ctrl', 'shift'}, 'D',
               function() hs.application.open('com.apple.Dictionary') end)

-- Open iTerm2
hs.hotkey.bind({'ctrl', 'shift'}, 'T',
               function() hs.application.open('com.googlecode.iterm2') end)

-- Finder sort by Name
hs.hotkey.bind({'cmd', 'shift'}, '1', nil, function()
    if hs.application.frontmostApplication():name() == 'Preview' then
        hs.eventtap.keyStroke({'cmd', 'alt'}, '1')
    end
end)

-- Finder sort by date
hs.hotkey.bind({'cmd', 'shift'}, '2', nil, function()
    if hs.application.frontmostApplication():name() == 'Finder' then
        hs.eventtap.keyStroke({'cmd', 'ctrl', 'alt'}, '5')
    end
end)

require 'window'
require 'config'
