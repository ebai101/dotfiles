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
    print(hs.loadSpoon('UADCtrl'))
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
launcher        = require('launcher')
windows         = require('windows')
reason          = require('reason')
browser         = require('browser')

hs.alert.show("config loaded")
