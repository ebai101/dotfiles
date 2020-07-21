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
        {'d', 'Alacritty',      '/Applications/Alacritty.app',              false},
        {'e', 'Brave Browser',  '/Applications/Brave Browser.app',          false},
        {'r', 'Messages',       '/Applications/Messages.app',               true },
        {'f', 'Mailspring',     '/Applications/Mailspring.app',             true },
        {'v', 'Finder',         '/System/Library/CoreServices/Finder.app',  true },
        {'c', 'Spotify',        '/Applications/Spotify.app',                true }
    }
elseif hs.host.localizedName() == 'hackerman' then
    apps = {
        {'d', 'Alacritty',      '/Applications/Alacritty.app',              false},
        {'e', 'Brave Browser',  '/Applications/Brave Browser.app',          false},
        {'r', 'Messages',       '/Applications/Messages.app',               true },
        {'f', 'Reason',         '/Applications/Reason.app',                 false},
        {'v', 'Finder',         '/System/Library/CoreServices/Finder.app',  true },
        {'c', 'Console',        '/Applications/Universal Audio/Console.app',true }
    }
end

local k = hs.hotkey.modal.new(hyper, 'p')
k:bind({}, 'escape', function() k:exit() end)
for i = 1, #apps do
    k:bind(hyper, apps[i][1], function() 
        if hs.application.frontmostApplication():title() == apps[i][2] and apps[i][4] then
            hs.application.frontmostApplication():hide()
        else
            hs.application.launchOrFocus(apps[i][3])
        end
    end)
end
