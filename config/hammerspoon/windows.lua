-----------------------------------------------
-- Hyper Windows
-----------------------------------------------

-- hs.hotkey.bind(shyper,  '1', moveWindowToDisplay("Acer XFA240"))
-- hs.hotkey.bind(shyper,  '2', moveWindowToDisplay("R240HY"))
-- local function moveWindowToDisplay(d)
--     return function()
--         hs.window.focusedWindow():moveToScreen(d, false, true)
--         hs.mouse.setAbsolutePosition(hs.geometry.rectMidPoint(hs.window.focusedWindow():frame()))
--     end
-- end

-- app launcher binds
local k = hs.hotkey.modal.new(hyper, 'p')
local kActive = false

k:bind({}, 'escape', function()
    k:exit()
    hs.alert.closeAll()
    hs.alert('🙅')
end)

function k:entered()
    kActive = true
    hs.timer.doAfter(1, function()
        if kActive then
            k:exit()
            hs.alert.closeAll()
            hs.alert('🙅', hs.alert.defaultStyle, hs.screen.mainScreen(), 0.5)
        end
    end)
    hs.alert.closeAll()
    hs.alert('🤔')
end

function k:exited()
    kActive = false
end

local function focus(appName, appFloat)
    local frontApp = hs.application.frontmostApplication()
    if frontApp:title() == appName then
        if appFloat then frontApp:hide() end
    else
        hs.application.launchOrFocus(appName)
    end
end

local apps = {
    {'e', function()
        focus('Google Chrome', false)
    end},
    {'r', function()
        focus('Messages', true)
    end},
    {'d', function()
        focus('Alacritty', false)
    end},
    {'f', function()
        -- open gmail in browser
        hs.execute('/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome "chrome-extension://oeopbcgkkoapgobdbedcemjljbihmemj/popup.html"')
    end},
    {'c', function()
        focus('Discord', false)
    end},
    {'v', function()
        focus('Finder', true)
    end},
    {'x', function()
        focus('Calendar', true)
    end}
}

for i = 1, #apps do
    local appHotkey = apps[i][1]
    local appFunc = apps[i][2]

    k:bind({}, appHotkey, function()
        hs.alert.closeAll()
        appFunc()
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
