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
hs.hotkey.bind(shyper, '0', function()
    hs.console.clearConsole()
    hs.reload()
end)

-- hold to quit
hs.loadSpoon('HoldToQuit')
spoon.HoldToQuit.duration = 0.3
spoon.HoldToQuit:init()
spoon.HoldToQuit:start()

-- uadctrl
-- hs.loadSpoon('UADCtrl')
-- spoon.UADCtrl:showAlerts(true)
-- spoon.UADCtrl:bindHotkeys({
--     enter = { hyper, 'u' },
--     mute  = { {}, 'm' },
--     solo  = { {}, 's' },
--     mono  = { {}, 'o' },
--     pan   = { {}, 'p' }
-- })

-- reason setup
hs.loadSpoon('Reason')
-- spoon.Reason:setPresetCommand([[ /opt/homebrew/bin/fd -tf . \
--     /Users/ethan/My\ Drive/PATCHES/EFFECTS \
--     /Users/ethan/My\ Drive/PATCHES/INSTRUMENTS \
--     /Users/ethan/My\ Drive/PATCHES/VOCALS \
--     -E "*.wav" -E "*.asd" -E "*RM-20*" -E "*.fxp" ]])
spoon.Reason:setPresetFolders({
    '/Users/ethan/My Drive/PATCHES/EFFECTS',
    '/Users/ethan/My Drive/PATCHES/INSTRUMENTS',
    '/Users/ethan/My Drive/PATCHES/VOCALS',
})
spoon.Reason:bindHotkeys()
spoon.Reason:start()

-- other externals
windows = require('windows')
reasonMisc = require('reason_misc')
dvdmenu = require('dvdmenu')

hs.alert.show('💯😎👌')
