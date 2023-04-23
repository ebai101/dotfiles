-----------------------------------------------
-- init.lua
-----------------------------------------------

require('hs.ipc')

hyper  = { 'cmd', 'ctrl', 'alt' }
shyper = { 'shift', 'cmd', 'ctrl', 'alt' }

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
hs.hotkey.bind(shyper, '0', hs.reload)
local hsWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', hs.reload):start()

-- hold to quit
hs.loadSpoon('HoldToQuit')
spoon.HoldToQuit.duration = 0.3
spoon.HoldToQuit:init()
spoon.HoldToQuit:start()

-- uadctrl
hs.loadSpoon('UADCtrl')
spoon.UADCtrl:showAlerts(true)
spoon.UADCtrl:bindHotkeys({
    enter = { hyper, 'u' },
    mute  = { {}, 'm' },
    solo  = { {}, 's' },
    mono  = { {}, 'o' },
    pan   = { {}, 'p' }
})

-- reason setup
hs.loadSpoon('Reason')
spoon.Reason:bindHotkeys()
spoon.Reason:start()

-- other externals
windows = require('windows')

hs.alert.show('💯😎👌')
