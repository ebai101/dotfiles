-----------------------------------------------
-- Hyper Windows
-----------------------------------------------

local apps = {}

-- different apps for different comps
if hs.host.localizedName() == 'mbp' then
    apps = {
        {'e', 'Google Chrome',  false},
        {'r', 'Messages',       true },
        {'d', 'Alacritty',      false},
        {'f', 'Mailspring',     true },
        {'c', 'Discord',        true },
        {'v', 'Finder',         true },
        {'x', 'Spotify',        true },
    }
elseif hs.host.localizedName() == 'hackerman' then
    apps = {
        {'e', 'Google Chrome',      false},
        {'r', 'Messages',           true },
        {'d', 'Alacritty',          false},
        {'f', 'Mailspring',         true },
        {'c', 'Discord',            false},
        {'v', 'Finder',             true },
        {'x', 'Spotify',            true }
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

-- focuser binds
hs.hotkey.bind(hyper,   'h', focuser('west'))
hs.hotkey.bind(hyper,   'j', focuser('south'))
hs.hotkey.bind(hyper,   'k', focuser('north'))
hs.hotkey.bind(hyper,   'l', focuser('east'))
-- hs.hotkey.bind(shyper,  '1', moveWindowToDisplay("Acer XFA240"))
-- hs.hotkey.bind(shyper,  '2', moveWindowToDisplay("R240HY"))

-- app launcher binds
local k = hs.hotkey.modal.new(hyper, 'p')
k:bind({}, 'escape', function() k:exit() end)

for i = 1, #apps do
    local appHotkey = apps[i][1]
    local appName = apps[i][2]
    local appFloat = apps[i][3]

    k:bind({}, appHotkey, function()
        local frontApp = hs.application.frontmostApplication()
        if frontApp:title() == appName then
            if appFloat then frontApp:hide() end
        else
            hs.application.launchOrFocus(appName)
        end
        k:exit()
    end)
end

-- vimwiki
k:bind({}, 'w', function()
    local frontWindow = hs.window.frontmostWindow()
    local vimWikiWindow = hs.window('vimwiki alacritty')

    if vimWikiWindow == nil then
        hs.task.new('/usr/local/bin/alacritty', nil, {'--config-file', os.getenv('HOME')..'/.config/alacritty/vimwiki.yml'}):start()
    elseif vimWikiWindow ~= frontWindow then
        vimWikiWindow:focus()
    elseif vimWikiWindow == frontWindow then
        vimWikiWindow:application():hide()
    end
    k:exit()
end)
