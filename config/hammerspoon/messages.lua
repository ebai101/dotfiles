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
    for i=1, #messagesHotkeys do messagesHotkeys[i]:enable() end
end

local function messagesDisableAll()
    for i=1, #messagesHotkeys do messagesHotkeys[i]:disable() end
end

local messagesWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
    if eventType == hs.application.watcher.activated then
        if appObject.bundleID == 'com.apple.iChat' or appName == 'Messages' then messagesEnableAll() end
    elseif eventType == hs.application.watcher.deactivated then
        if appObject.bundleID == 'com.apple.iChat' or appName == 'Messages' then messagesDisableAll() end
    end
end)
messagesWatcher:start()
