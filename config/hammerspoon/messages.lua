-----------------------------------------------
-- Messages
-- Page Up: Select Previous Conversation
-- Page Down: Select Next Conversation
-----------------------------------------------
local messagesHotkeys = {}

table.insert(messagesHotkeys, hs.hotkey.new({}, 'pageup', function()
    local messages = hs.appfinder.appFromName('Messages')
    messages:selectMenuItem({'Window', 'Select Previous Conversation'})
end))

table.insert(messagesHotkeys, hs.hotkey.new({}, 'pagedown', function()
    local messages = hs.appfinder.appFromName('Messages')
    messages:selectMenuItem({'Window', 'Select Next Conversation'})
end))

local function messagesEnableAll()
    for i=1, #messagesHotkeys do
        messagesHotkeys[i]:enable()
    end
end

local function messagesDisableAll()
    for i=1, #messagesHotkeys do
        messagesHotkeys[i]:disable()
    end
end

messagesWindowFilter = hs.window.filter.new(false)
    :setAppFilter('Messages')
    :subscribe(hs.window.filter.windowFocused,function() messagesEnableAll() end)
    :subscribe(hs.window.filter.windowUnfocused,function() messagesDisableAll() end)
