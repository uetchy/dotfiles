require 'config'
require 'window'
require 'eikana'
require 'esc'

require 'finder'

-- Open Dictionary
hs.hotkey.bind({'ctrl', 'shift'}, 'D',
               function() hs.application.open('com.apple.Dictionary') end)

-- Open iTerm2
hs.hotkey.bind({'ctrl', 'shift'}, 'T',
               function() hs.application.open('com.googlecode.iterm2') end)
