hsapplication   = require('hs.application')
hswindow        = require('hs.window')
hs.loadSpoon('MiroWindowsManager')

-- miro setup
local hyper     = {"cmd", "ctrl", "alt"}
local shyper    = {"shift", "cmd", "ctrl", "alt"}

hs.window.animationDuration = 0.0
spoon.MiroWindowsManager:bindHotkeys({
    up          = {shyper, "k"},
    right       = {shyper, "l"},
    down        = {shyper, "j"},
    left        = {shyper, "h"},
    fullscreen  = {shyper, "f"}
})

-- console stuff
hs.console.darkMode(true)
hs.console.toolbar(nil)
hs.hotkey.bind(shyper, '0', function()
    if hs.window.focusedWindow():application():title() == 'Hammerspoon' then
        hs.window.focusedWindow():application():hide()
    else
        hs.openConsole()
    end
end)

-- reload
hs.hotkey.bind(shyper, 'r', hs.reload)

hs.alert.show("config loaded")

launcher        = require('launcher')
windows         = require('windows')
messages        = require('messages')
reason          = require('reason')
google          = require('google')





