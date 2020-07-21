-----------------------------------------------
-- Hyper App Launcher
-- O: Activate launcher mode
-- Esc: Deactivate launcher mode
-----------------------------------------------

local hyper = {"cmd", "alt", "ctrl"}
local apps = {}

-- different apps for different comps
if hs.host.localizedName() == 'mbp' then
    apps = {
        {'d', 'Alacritty',      false},
        {'e', 'Brave Browser',  false},
        {'r', 'Messages',       true },
        {'f', 'Mailspring',     true },
        {'v', 'Finder',         true },
        {'c', 'Spotify',        true }
    }
elseif hs.host.localizedName() == 'hackerman' then
    apps = {
        {'d', 'Reason',             false},
        {'e', 'Brave Browser',      false},
        {'r', 'Messages',           true },
        {'f', 'Mail',               false},
        {'v', 'Finder',             true },
        {'c', 'com.uaudio.console', true }
    }
end

local k = hs.hotkey.modal.new(hyper, 'p')
k:bind({}, 'escape', function() k:exit() end)
for i = 1, #apps do
    k:bind(hyper, apps[i][1], function() 
        if hs.application.frontmostApplication():title() == apps[i][2] and apps[i][3] then
            hs.application.frontmostApplication():hide()
        else
            if not hs.application.launchOrFocus(apps[i][2]) then
                hs.application.launchOrFocusByBundleID(apps[i][2])
            end
        end
        k:exit()
    end)
end
