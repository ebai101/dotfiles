local source_path = nil

local function get_source()
	if source_path ~= nil then
		return source_path
	end
	local output = vim.fn.system("chezmoi source-path"):gsub("[\r\n]+$", "")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	source_path = output
	return source_path
end

local function in_source_dir(path)
	local dir = get_source()
	if dir == nil or dir == "" then
		return false
	end
	return path == dir or path:sub(1, #dir + 1) == dir .. "/"
end

local function apply()
	vim.system({ "chezmoi", "apply" }, { detach = true }, function(res)
		if res.code ~= 0 then
			vim.notify("chezmoi apply failed", vim.log.levels.ERROR)
		end
	end)
end

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("ChezmoiApply", { clear = true }),
	callback = function(args)
		if in_source_dir(vim.fs.normalize(vim.api.nvim_buf_get_name(args.buf))) then
			apply()
		end
	end,
})
