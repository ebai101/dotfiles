-----------------------------------------------
-- init.lua
-----------------------------------------------

hsapplication   = require('hs.application')
hswindow        = require('hs.window')
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

-- reload
hs.hotkey.bind(shyper, '0', hs.reload)

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

-- other externals
windows         = require('windows')
reason          = require('reason')
browser         = require('browser')
usb             = require('usb')

hs.alert.show("config loaded")
