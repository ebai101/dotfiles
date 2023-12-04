dvdmenu = {}

dvdmenu.menubar = hs.menubar.new(true, 'dvdmenu')
dvdmenu.menubar:setTitle('dvd')
dvdmenu.menubar:setMenu({
    {
        title = 'bounce window',
        fn = function()
            dvdmenu:addWindow()
        end
    },
    {
        title = 'stop the bouncing',
        fn = function()
            dvdmenu:stopAllWindows()
        end
    }
})
dvdmenu.windows = {}
dvdmenu.eventtap = hs.eventtap.new(
    { hs.eventtap.event.types.leftMouseUp }, function(event)
        dvdmenu:startAnimatingWindow()
    end)
dvdmenu.isRunning = false

function dvdmenu:addWindow()
    dvdmenu.eventtap:start()
    hs.alert.closeAll()
    hs.alert('click a window')

    -- auto cancel
    hs.timer.doAfter(3, function()
        dvdmenu.eventtap:stop()
    end)
end

function dvdmenu:getWindowUnderMouse()
    -- Invoke `hs.application` because `hs.window.orderedWindows()` doesn't do it
    -- and breaks itself
    local _ = hs.application

    local my_pos = hs.geometry.new(hs.mouse.absolutePosition())
    local my_screen = hs.mouse.getCurrentScreen()

    return hs.fnutils.find(hs.window.orderedWindows(), function(w)
        return my_screen == w:screen() and my_pos:inside(w:frame())
    end)
end

function dvdmenu:startAnimatingWindow()
    dvdmenu.eventtap:stop()
    local window = dvdmenu:getWindowUnderMouse()
    local id = window:id()
    local direction = hs.geometry.point(
        math.random() >= 0.5 and 20 or -20,
        math.random() >= 0.5 and 20 or -20
    )
    if dvdmenu.windows[id] == nil then
        dvdmenu.windows[id] = { window = window, direction = direction }
    end

    if not dvdmenu.isRunning then
        dvdmenu.mover = hs.timer.doEvery(0.1, function()
            dvdmenu:animate()
        end)
    end
    dvdmenu.isRunning = true
end

function dvdmenu:animate()
    for _, win in pairs(dvdmenu.windows) do
        local w = win.window
        local dir = win.direction
        local wf = w:frame()
        local sf = w:screen():frame()

        if (wf.x <= sf.x or wf.x + wf.w >= sf.x + sf.w) then
            dir.x = dir.x * -1
        end
        if (wf.y <= sf.y or wf.y + wf.h >= sf.y + sf.h) then
            dir.y = dir.y * -1
        end

        w:move(dir, nil, false, 0.1)
    end
end

function dvdmenu:stopAllWindows()
    dvdmenu.mover:stop()
    dvdmenu.windows = {}
    dvdmenu.isRunning = false
    hs.alert.closeAll()
end

return dvdmenu
