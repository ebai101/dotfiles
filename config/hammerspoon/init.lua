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
hs.hotkey.bind(shyper, '0', function()
    if hs.application.frontmostApplication():title() == 'Hammerspoon' then
        hs.window.focusedWindow():application():hide()
    else
        hs.openConsole()
    end
end)

-- reload
hs.hotkey.bind(shyper, 'r', hs.reload)

-- uadctrl setup
print(hs.loadSpoon('UADCtrl'))
spoon.UADCtrl:bindHotkeys({
    activate = {hyper, 'u'}
})

-- other externals
launcher        = require('launcher')
windows         = require('windows')
reason          = require('reason')
google          = require('google')

hs.alert.show("config loaded")
