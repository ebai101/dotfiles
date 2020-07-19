local reasonApp = hs.appfinder.appFromName('Reason')
local reasonLog = hs.logger.new('reason', 'info')
local isEmptyString = function(s) return s == nil or s == '' end
local reasonHotkeys = {}

-- Navigation
-- table.insert(reasonHotkeys, hs.hotkey.new('cmd', '1', function()
--     hs.osascript.javascript([[
--         Application('System Events')
--             .processes.byName('Reason')
--             .menuBars[0].menuBarItems.byName('File')
--             .click();
--     ]])
-- end))

-- Better create effect - chooser to search the menus for rack units/plugins like Ableton
local bceChooserOptions = {}
local bceCreateChooserOptions = function()
    bceChooserOptions = {}
    reasonLog.i('creating chooser options list')
    
    local menus = reasonApp:getMenuItems()[4]['AXChildren'][1]
    for i=7, 9 do
        for j=11, #menus[i]['AXChildren'][1] do
            for k=1, #menus[i]['AXChildren'][1][j]['AXChildren'][1] do
                if not isEmptyString(menus[i]['AXChildren'][1][j]['AXChildren'][1][k]['AXTitle']) then
                    table.insert(bceChooserOptions, {
                            ["text"] = menus[i]['AXChildren'][1][j]['AXChildren'][1][k]['AXTitle'],
                            ["subtext"] = string.format('%s - %s',
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
    for i=1, #menus[10]['AXChildren'][1] do
        if not isEmptyString(menus[10]['AXChildren'][1][i]['AXTitle']) then
            table.insert(bceChooserOptions, {
                    ["text"] = menus[10]['AXChildren'][1][i]['AXTitle'],
                    ["subtext"] = "Players",
                    ["menuSelector"] = {
                        "Create", "Players",
                        menus[10]['AXChildren'][1][i]['AXTitle'],
                    }
                })
        end
    end

    reasonLog.i('done creating chooser options list')
end

table.insert(reasonHotkeys, hs.hotkey.new('cmd', 'f', function()
    local chooser = hs.chooser.new(function(choice) 
        reasonLog.i(hs.inspect(choice))
        reasonApp:selectMenuItem(choice['menuSelector'])
    end)
    chooser:choices(bceChooserOptions)
    chooser:bgDark(true)
    chooser:show()
end))

-- window filter setup
local reasonEnableAll = function()
    for i=1, #reasonHotkeys do
        reasonHotkeys[i]:enable()
    end
    bceCreateChooserOptions()
end

local reasonDisableAll = function()
    for i=1, #reasonHotkeys do
        reasonHotkeys[i]:disable()
    end
end

reasonWindowFilter = hs.window.filter.new(false)
    :setAppFilter('Reason', {allowTitles='.reason'})
    :subscribe(hs.window.filter.windowFocused,function() reasonEnableAll() end)
    :subscribe(hs.window.filter.windowUnfocused,function() reasonDisableAll() end)
