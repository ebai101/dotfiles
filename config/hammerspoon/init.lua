-----------------------------------------------
-- init.lua
-----------------------------------------------

-- require('hs.ipc')

hyper  = { 'cmd', 'ctrl', 'alt' }
shyper = { 'shift', 'cmd', 'ctrl', 'alt' }

hs.loadSpoon('EmmyLua')

-- miro setup
hs.loadSpoon('MiroWindowsManager')
hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
    up         = { shyper, 'k' },
    right      = { shyper, 'l' },
    down       = { shyper, 'j' },
    left       = { shyper, 'h' },
    fullscreen = { shyper, 'f' }
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

-- hold to quit
hs.loadSpoon('HoldToQuit')
spoon.HoldToQuit.duration = 0.3
spoon.HoldToQuit:init()
spoon.HoldToQuit:start()

-- ejectmenu
-- hs.loadSpoon('EjectMenu')
-- spoon.EjectMenu:start()

-- reason setup
hs.loadSpoon('Reason')
spoon.Reason:setPresetFolders({
    '/Users/ethan/My Drive/PATCHES/EFFECTS',
    '/Users/ethan/My Drive/PATCHES/INSTRUMENTS',
    '/Users/ethan/My Drive/PATCHES/VOCALS',
})
spoon.Reason:bindHotkeys()
spoon.Reason:start()

-- ableton setup
hs.loadSpoon('Ableton')
spoon.Ableton:bindHotkeys()
spoon.Ableton:start()

-- other externals
axhf = require('axhotfix')
windows = require('windows')
reasonMisc = require('reason_misc')
-- dvdmenu = require('dvdmenu')
-- crosshair = require('crosshair')

hs.hotkey.bind(shyper, '0', function()
    spoon.Ableton:stop()
    hs.console.clearConsole()
    hs.reload()
end)

hs.alert.show('💯😎👌')
