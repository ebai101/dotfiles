-- local function bofHelper(dirname)
--     local i, d = hs.fs.dir(dirname)
--     for f in i, d do
--         if not(f == '.' or f == '..') then
--             local fullPath = hs.fs.pathToAbsolute(dirname .. '/' .. f)
--             if hs.fs.attributes(fullPath).mode == 'directory' then bofHelper(fullPath)
--             elseif string.match(f, '.reason') then
--                 table.insert(bofChooserOptions, {
--                         ["text"] = f,
--                         ["subtext"] = fullPath
--                     })
--                 bofChooser:choices(bofChooserOptions)
--             end
--         end
--     end
-- end

local reasonApp = hs.appfinder.appFromName('Reason')
local reasonLog = hs.logger.new('reason', 'info')
local isEmptyString = function(s) return s == nil or s == '' end
local reasonHotkeys = {}

-- Better open file - searches songs directory for reason files
local bofChooserOptions = {}
local bofChooser = hs.chooser.new(function(choice) hs.open(choice['subtext']) end)
    :bgDark(true)
    :choices(bofChooserOptions)

local function bofUpdateChooser(task, out, err)
    reasonLog.i(out)
end

local function bofCreateChooserOptions()
    bofChooserOptions = {}
    reasonLog.i('creating Better Open File list')

    local findTask = hs.task.new('/usr/bin/find', nil, bofUpdateChooser, { '.', '-name', '"*.reason"' })
findTask:start()

    reasonLog.i('done creating Better Open File list')
end
bofChooser:showCallback(bofCreateChooserOptions)

table.insert(reasonHotkeys, hs.hotkey.new('cmd', 'o', function() bofChooser:show() end))

-- Better create effect - chooser to search the menus for rack units/plugins like Ableton
local bceChooserOptions = {}
local function bceCreateChooserOptions()
    bceChooserOptions = {}
    reasonLog.i('creating Better Create Effect list')

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

    reasonLog.i('done creating Better Create Effect list')
end

table.insert(reasonHotkeys, hs.hotkey.new('cmd', 'f', function()
    local chooser = hs.chooser.new(function(choice) 
        reasonApp:selectMenuItem(choice['menuSelector'])
    end)
    chooser:choices(bceChooserOptions)
    chooser:bgDark(true)
    chooser:show()
end))

-- app watcher setup
local function reasonEnableAll()
    for i=1, #reasonHotkeys do
        reasonHotkeys[i]:enable()
    end
    bceCreateChooserOptions()
end

local function reasonDisableAll()
    for i=1, #reasonHotkeys do
        reasonHotkeys[i]:disable()
    end
end

reasonAppWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
    if eventType == hs.application.watcher.activated then
        if appName == 'Reason' then reasonEnableAll() end
    elseif eventType == hs.application.watcher.deactivated then
        if appName == 'Reason' then reasonDisableAll() end
    end
end)
reasonAppWatcher:start()
