-----------------------------------------------
-- Hyper App Launcher
-- P: Activate launcher mode
-- Esc: Deactivate launcher mode
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
        {'e', 'Brave Browser',      false},
        {'r', 'Messages',           true },
        {'d', 'Reason',             false},
        {'f', 'Mail',               false},
        {'c', 'com.uaudio.console', true },
        {'v', 'Finder',             true }
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
