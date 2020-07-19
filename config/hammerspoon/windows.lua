-----------------------------------------------
-- Hyper Windows
-- HJKL: select left, down, up, right
-- I: show hints
-- TB: selects front window on top/bottom (not implemented yet)
-- Shift-TB: moves front window to top/bottom
-----------------------------------------------

local hyper = {"cmd", "alt", "ctrl"}
local shyper = {"shift", "cmd", "alt", "ctrl"}

local focuser = function(direction)
    return function()
        local current = hs.window.focusedWindow() or hs.application.frontmostApplication():allWindows()[1] or hs.window.desktop()
        if not current then
            hs.alert.show('No active window')
            return
        end
        if     direction == 'north' then current:focusWindowNorth()
        elseif direction == 'south' then current:focusWindowSouth()
        elseif direction == 'east'  then current:focusWindowEast()
        elseif direction == 'west'  then current:focusWindowWest()
        end
        hs.mouse.setAbsolutePosition(hs.geometry.rectMidPoint(hs.window.focusedWindow():frame()))
    end
end

local moveWindowToDisplay = function(d)
    return function()
        hs.window.focusedWindow():moveToScreen(hs.screen.allScreens()[d], false, true)
        hs.mouse.setAbsolutePosition(hs.geometry.rectMidPoint(hs.window.focusedWindow():frame()))
    end
end

hs.hotkey.bind(hyper,   'h', focuser('west'))
hs.hotkey.bind(hyper,   'j', focuser('south'))
hs.hotkey.bind(hyper,   'k', focuser('north'))
hs.hotkey.bind(hyper,   'l', focuser('east'))
hs.hotkey.bind(shyper,  't', moveWindowToDisplay(1))
hs.hotkey.bind(shyper,  'b', moveWindowToDisplay(2))

hs.hints.style = 'vimperator'
hs.hints.showTitleThresh = 1
hs.hotkey.bind(hyper, 'i', hs.hints.windowHints)
