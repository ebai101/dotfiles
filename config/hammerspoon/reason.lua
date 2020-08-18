-----------------------------------------------
-- Reason Hotkeys
-----------------------------------------------

local reasonApp = hs.appfinder.appFromName('Reason')
local reasonLog = hs.logger.new('reason', 'info')
local reasonHotkeys = {}

-- Better open file - searches songs directory for reason files
local bofChooser = hs.chooser.new(function(choice) hs.open(choice['subText']) end)
    :searchSubText(true)
    :bgDark(true)

local function bofPopulate()
    local options = {}
    reasonLog.i('creating Better Open File list')
    hs.task.new('/usr/bin/find', function(task, out, err)
        for path in out:gmatch("[^\r\n]+") do
            table.insert(options, {
                    ['text'] = string.match(path, ".*/(.+)%..+$"),
                    ['subText'] = path,
                    ['modified'] = hs.fs.attributes(path).modification
                })
        end
        table.sort(options, function(a, b)
            return a['modified'] > b['modified']
        end)
        bofChooser:choices(options)
        reasonLog.i('done creating Better Open File list')
    end, { '/Volumes/FilesHDD/SONGS', '-name', '*.reason' }):start()
end
bofChooser:showCallback(bofPopulate)

table.insert(reasonHotkeys, hs.hotkey.new('cmd', 'o', function() bofChooser:show() end))

-- Better create effect - chooser to search the menus for rack units/plugins like Ableton
local bceChooser = hs.chooser.new(function(choice) if choice then reasonApp:selectMenuItem(choice['menuSelector']) end end):bgDark(true)

local function bcePopulate()
    local options = {}
    reasonLog.i('creating Better Create Effect list')

    local menus = reasonApp:getMenuItems()[4]['AXChildren'][1]
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

    bceChooser:choices(options)
    reasonLog.i('done creating Better Create Effect list')
end
table.insert(reasonHotkeys, hs.hotkey.new('cmd', 'f', function() bceChooser:show() end))

-- window filter setup
local function reasonEnableAll()
    for i=1, #reasonHotkeys do reasonHotkeys[i]:enable() end
    bcePopulate()
end

local function reasonDisableAll()
    for i=1, #reasonHotkeys do reasonHotkeys[i]:disable() end
end

local reasonFilter = hs.window.filter.new('Reason')
reasonFilter:subscribe(hs.window.filter.windowFocused, function() reasonEnableAll() end)
reasonFilter:subscribe(hs.window.filter.windowUnfocused, function() reasonDisableAll() end)
