-----------------------------------------------
-- Hyper App Launcher
-- P: Activate launcher mode
-- Esc: Deactivate launcher mode
-----------------------------------------------

local apps = {}

-- different apps for different comps
if hs.host.localizedName() == 'mbp' then
    apps = {
        {'q', 'Brave Browser',  false},
        {'w', 'Messages',       true },
        {'a', 'Alacritty',      false},
        {'s', 'Mailspring',     true },
        {'z', 'Spotify',        true },
        {'x', 'Finder',         true }
    }
elseif hs.host.localizedName() == 'hackerman' then
    apps = {
        {'q', 'Brave Browser',      false},
        {'w', 'Messages',           true },
        {'a', 'com.ableton.live',   false},
        {'s', 'Mail',               false},
        {'z', 'com.uaudio.console', true },
        {'x', 'Finder',             true }
    }
end

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
