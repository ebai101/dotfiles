-----------------------------------------------
-- Hyper Browser
-----------------------------------------------

local browserHotkeys = {}

table.insert(browserHotkeys, hs.hotkey.new({}, 'f13', function()
    hs.eventtap.keyStroke({'ctrl', 'shift'}, 'tab')
end))

table.insert(browserHotkeys, hs.hotkey.new({}, 'f15', function()
    hs.eventtap.keyStroke({'ctrl'}, 'tab')
end))

-- window filter setup
local function browserEnableAll()
    for i=1, #browserHotkeys do browserHotkeys[i]:enable() end
end

local function browserDisableAll()
    for i=1, #browserHotkeys do browserHotkeys[i]:disable() end
end

local browserFilter = hs.window.filter.new('Brave Browser')
browserFilter:subscribe(hs.window.filter.windowFocused, function() browserEnableAll() end)
browserFilter:subscribe(hs.window.filter.windowUnfocused, function() browserDisableAll() end)
