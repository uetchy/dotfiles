hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'R', function()
    hs.notify.show('Config reloaded', '', '')
    hs.reload()
end)
