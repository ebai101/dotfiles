-----------------------------------------------
-- init.lua
-----------------------------------------------

hyper           = {'cmd', 'ctrl', 'alt'}
shyper          = {'shift', 'cmd', 'ctrl', 'alt'}

-- miro setup
hs.loadSpoon('MiroWindowsManager')
hs.window.animationDuration = 0.0
spoon.MiroWindowsManager:bindHotkeys({
    up          = {shyper, 'k'},
    right       = {shyper, 'l'},
    down        = {shyper, 'j'},
    left        = {shyper, 'h'},
    fullscreen  = {shyper, 'f'}
})


-- ejectmenu setup
hs.loadSpoon('EjectMenu')
spoon.EjectMenu.show_in_menubar = false
spoon.EjectMenu:bindHotkeys({ejectAll={hyper, 'forwarddelete'}})

-- console stuff
hs.console.darkMode(true)
hs.console.toolbar(nil)
hs.hotkey.bind(hyper, '0', function()
    if hs.application.frontmostApplication():title() == 'Hammerspoon' then
        hs.window.focusedWindow():application():hide()
    else
        hs.openConsole()
    end
end)

-- misc keys
hs.hotkey.bind(shyper, '0', function()
    -- Reason.reasonWatcher:stop()
    hs.reload()
end)

hs.hotkey.bind({}, 'f19', function()
    hs.eventtap.keyStroke(hyper, 'space')
end)

-- wifi toggle
hs.hotkey.bind(shyper, 'w', function()
    local state = not hs.wifi.interfaceDetails().power
    hs.wifi.setPower(state)
    hs.alert.closeAll()
    hs.alert.show('wifi ' .. (state and 'on' or 'off'))
end)

-- caffeinate toggle
hs.hotkey.bind(shyper, 'c', function()
    local state = not hs.caffeinate.get('displayIdle')
    hs.caffeinate.set('displayIdle', state)
    hs.alert.closeAll()
    hs.alert.show('caffeinate ' .. (state and 'on' or 'off'))
end)

-- -- display rotate toggle
-- hs.hotkey.bind(shyper, 'r', function()
--     local state = hs.screen.find("R240HY"):rotate()
--     hs.screen.find("R240HY"):rotate((state == 0 and 270 or 0))
-- end)

-- system preferences
hs.hotkey.bind(hyper, ',', function()
    hs.application.launchOrFocus('System Preferences')
end)

-- uadctrl setup
if hs.host.localizedName() == 'hackerman' then
    hs.loadSpoon('UADCtrl')
    spoon.UADCtrl:showAlerts(true)
    spoon.UADCtrl:bindHotkeys({
        enter  = { hyper,  'u' },
        mute   = { {},     'm' },
        solo   = { {},     's' },
        mono   = { {},     'o' },
        pan    = { {},     'p' }
    })
end

-- reason setup
hs.loadSpoon('Reason')
spoon.Reason:bindHotkeys({
    bce = { 'cmd', 'f' }
})

-- other externals
windows         = require('windows')
browser         = require('browser')
tagging         = require('quicktags')
scroll          = require('scroll')

hs.alert.show("💯😎👌")
