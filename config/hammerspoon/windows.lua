-----------------------------------------------
-- Hyper Windows
-----------------------------------------------

local apps = {}

-- different apps for different comps
if hs.host.localizedName() == 'mbp' then
    apps = {
        {'e', 'Brave Browser',  false},
        {'r', 'Messages',       true },
        {'d', 'Alacritty',      false},
        {'f', 'Mailspring',     true },
        {'c', 'Spotify',        true },
        {'v', 'Finder',         true }
    }
elseif hs.host.localizedName() == 'hackerman' then
    apps = {
        {'e', 'Google Chrome',      false},
        {'r', 'Messages',           true },
        {'d', 'Alacritty',          false},
        {'f', 'Mail',               true },
        {'c', 'Discord',            false },
        {'v', 'Finder',             true }
    }
end

local function focuser(direction)
    return function()
        local current = hs.window.focusedWindow()
        if not current then
            hs.alert.show('No active window')
            return
        end

        if     direction == 'north' then current:focusWindowNorth()
        elseif direction == 'south' then current:focusWindowSouth()
        elseif direction == 'east'  then current:focusWindowEast()
        elseif direction == 'west'  then current:focusWindowWest()
        end

        for i=1, #apps do
            if apps[i][2] == current:application():title() and apps[i][3] == true then
                current:application():hide()
                break
            end
        end

        hs.mouse.setAbsolutePosition(hs.geometry.rectMidPoint(hs.window.focusedWindow():frame()))
    end
end

local function moveWindowToDisplay(d)
    return function()
        hs.window.focusedWindow():moveToScreen(d, false, true)
        hs.mouse.setAbsolutePosition(hs.geometry.rectMidPoint(hs.window.focusedWindow():frame()))
    end
end

hs.hotkey.bind(hyper,   'h', focuser('west'))
hs.hotkey.bind(hyper,   'j', focuser('south'))
hs.hotkey.bind(hyper,   'k', focuser('north'))
hs.hotkey.bind(hyper,   'l', focuser('east'))
hs.hotkey.bind(shyper,  '1', moveWindowToDisplay("R240HY"))
hs.hotkey.bind(shyper,  '2', moveWindowToDisplay("Acer XFA240"))

hs.hints.style = 'vimperator'
hs.hints.showTitleThresh = 1
hs.hotkey.bind(hyper, 'i', hs.hints.windowHints)

local k = hs.hotkey.modal.new(hyper, 'p')
k:bind({}, 'escape', function() k:exit() end)

for i = 1, #apps do
    k:bind(hyper, apps[i][1], function()
        local frontApp = hs.application.frontmostApplication()
        if frontApp:title() == apps[i][2] or frontApp:bundleID() == apps[i][2] then
            if apps[i][3] then hs.application.frontmostApplication():hide() end
        else
            if not hs.application.launchOrFocus(apps[i][2]) then
                hs.application.launchOrFocusByBundleID(apps[i][2])
            end
        end
        k:exit()
    end)
end

