-- Original Author: bakurou @ https://mac-ra.com/post-965/
local simpleCmd = false
local leftSet = false
local rightSet = false

local escape = 0x35
local leftCmd = 0x37
local rightCmd = 0x36
local alphanum = 0x66
local kana = 0x68

local function keyStroke(modifiers, character)
    hs.eventtap.keyStroke(modifiers, character, 5000)
end

local function eikanaEvent(event)
    local c = event:getKeyCode()
    local f = event:getFlags()

    if event:getType() == hs.eventtap.event.types.keyDown then
        if f['cmd'] and c then simpleCmd = true end

    elseif event:getType() == hs.eventtap.event.types.flagsChanged then
        if f['cmd'] then
            if c == leftCmd then
                leftSet = true
                rightSet = false
            elseif c == rightCmd then
                rightSet = true
                leftSet = false
            end
        else
            if simpleCmd == false then
                if leftSet then
                    keyStroke({}, alphanum)
                elseif rightSet then
                    keyStroke({}, kana)
                end
            end
            simpleCmd = false
            leftSet = false
            rightSet = false
        end
    end
end

eikana = hs.eventtap.new({
    hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged
}, eikanaEvent)

eikana:start()
