local function openFile(choice)
	if not choice then return end
	local openFilename = choice['subText']
	local openCommand = string.format('open -a Reason\\ 12 "%s"', openFilename)
	hs.execute(openCommand)
end

local openFileChooser = hs.chooser.new(function(choice)
	return openFile(choice)
end)

local openFileHotkey = hs.hotkey.new({ 'cmd', 'ctrl', 'alt' }, 'o', function()
	local command = hs.execute([[/opt/homebrew/bin/fd -tf -0 . /Users/ethan/My\ Drive/SONGS -e reason | xargs -0 ls -t]])
	local files = {}

	for line in string.gmatch(command, '[^\r\n]+') do
		local name = line:match('^.+/(.+)$')
		table.insert(files, {
			['text'] = name,
			['subText'] = line,
		})
	end

	openFileChooser:choices(files)
	openFileChooser:show()
end)

openFileWatcher = hs.application.watcher.new(function(appName, eventType)
	if appName == 'Reason' then
		if eventType == hs.application.watcher.activated then
			openFileHotkey:enable()
		elseif eventType == hs.application.watcher.deactivated then
			openFileHotkey:disable()
		end
	end
end):start()

print('loaded open file')
