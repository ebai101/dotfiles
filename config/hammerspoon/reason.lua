-----------------------------------------------
-- Reason Hotkeys
-----------------------------------------------

reasonApp = hs.appfinder.appFromName('Reason')
reasonLog = hs.logger.new('reason', 'info')
reasonHotkeys = {}

-- Better create effect - chooser to search the menus for rack units/plugins like Ableton
bceChooser = hs.chooser.new(function(choice) if choice then reasonApp:selectMenuItem(choice['menuSelector']) end end)
bceChooser:bgDark(false)

function bcePopulate()
    local options = {}

    reasonApp = hs.appfinder.appFromName('Reason')
    if reasonApp:getMenuItems() == nil then return end
    local menus = reasonApp:getMenuItems()[4]['AXChildren'][1]

    -- reasonLog.i('instruments, effects, utilities')
    for i=7, 9 do
        for j=11, #menus[i]['AXChildren'][1] do
            for k=1, #menus[i]['AXChildren'][1][j]['AXChildren'][1] do
                if not(menus[i]['AXChildren'][1][j]['AXChildren'][1][k]['AXTitle'] == '') then
                    reasonLog.d(menus[i]['AXChildren'][1][j]['AXChildren'][1][k]['AXTitle'])
                    table.insert(options, {
                            ["text"] = menus[i]['AXChildren'][1][j]['AXChildren'][1][k]['AXTitle'],
                            ["subText"] = string.format('%s - %s',
                                menus[i]['AXTitle'],
                                menus[i]['AXChildren'][1][j]['AXTitle']
                                ),
                            ["menuSelector"] = {
                                "Create",
                                menus[i]['AXTitle'],
                                menus[i]['AXChildren'][1][j]['AXTitle'],
                                menus[i]['AXChildren'][1][j]['AXChildren'][1][k]['AXTitle'],
                            }
                        })
                end
            end
        end
    end
    -- reasonLog.i('players')
    for i=1, #menus[10]['AXChildren'][1] do
        if not menus[10]['AXChildren'][1][i]['AXTitle'] == '' then
            reasonLog.d(menus[10]['AXChildren'][1][i]['AXTitle'])
            table.insert(options, {
                    ["text"] = menus[10]['AXChildren'][1][i]['AXTitle'],
                    ["subText"] = "Players",
                    ["menuSelector"] = {
                        "Create", "Players",
                        menus[10]['AXChildren'][1][i]['AXTitle'],
                    }
                })
        end
    end

    -- write json cache
    hs.json.write(options, 'reason_bce_data.json', false, true)
    bceChooser:choices(options)
    hs.alert('reloaded')
end
table.insert(reasonHotkeys, hs.hotkey.new('cmd', 'f', function()
    if bceChooser:isVisible() then
        bcePopulate()
    else
        bceChooser:choices(hs.json.read('reason_bce_data.json'))
    end
    bceChooser:show()
end))

-- window filter setup
-- reasonFilter = hs.window.filter.new('Reason')
-- reasonFilter:subscribe(hs.window.filter.windowFocused, function() reasonEnableAll() end)
-- reasonFilter:subscribe(hs.window.filter.windowUnfocused, function() reasonDisableAll() end)

function reasonEnableAll()
    for i=1, #reasonHotkeys do reasonHotkeys[i]:enable() end
end

function reasonDisableAll()
    for i=1, #reasonHotkeys do reasonHotkeys[i]:disable() end
end

function reasonWatcherCallback(appName, eventType, app)
    if appName == 'Reason' then
        if eventType == hs.application.watcher.activated then
            reasonLog.i('reason activated')
            reasonEnableAll()
        elseif eventType == hs.application.watcher.deactivated then
            reasonLog.i('reason deactivated')
            reasonDisableAll()
        end
    end
end

reasonWatcher = hs.application.watcher.new(reasonWatcherCallback)
reasonWatcher:start()
