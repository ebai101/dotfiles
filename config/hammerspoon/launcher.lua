-----------------------------------------------
-- Hyper App Launcher
-- O: Activate launcher mode
-- Esc: Deactivate launcher mode
-----------------------------------------------

local hyper = {"cmd", "alt", "ctrl"}

-- hotkey, app name, floating
local apps = {
    {'d', 'iTerm',          false},
    {'e', 'Brave Browser',  false},
    {'r', 'Messages',       true},
    {'f', 'Mailspring',     true},
    {'v', 'Finder',         true},
    {'c', 'Spotify',        true}
}

local k = hs.hotkey.modal.new(hyper, 'p')

local launchApp = function(appname, floating)
    if hs.window.focusedWindow():application():title() == appname and floating then
        hs.window.focusedWindow():application():hide()
    else
        hs.application.launchOrFocus(appname)
    end
end

for i = 1, #apps do
    k:bind({}, apps[i][1], function() launchApp(apps[i][2], apps[i][3]); k:exit(); end)
end

k:bind({}, 'escape', function() k:exit() end)
