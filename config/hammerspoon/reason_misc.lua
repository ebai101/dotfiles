local log = hs.logger.new('reasonopen', 'debug')

local function openFile(choice)
	if not choice then
		return
	end
	local openFilename = choice['subText']
	local openCommand = string.format('open -a Reason\\ 13 "%s"', openFilename)
	hs.execute(openCommand)
end

local openFileChooser = hs.chooser.new(function(choice)
	return openFile(choice)
end)

local openFileHotkey = hs.hotkey.new(hyper, 'o', function()
	local command = hs.execute(
		[[/opt/homebrew/bin/fd -tf -0 . /Users/ethan/My\ Drive/SONGS /Volumes/CrucialX9/mixing -e reason | xargs -0 ls -t]]
	)
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

openFileWatcher = hs.application.watcher
	.new(function(appName, eventType)
		if appName == 'Reason' then
			if eventType == hs.application.watcher.activated then
				openFileHotkey:enable()
				log.d('enabled reason file opener')
			elseif eventType == hs.application.watcher.deactivated then
				openFileHotkey:disable()
				log.d('disabled reason file opener')
			end
		end
	end)
	:start()

log.d('loaded reason file opener')
