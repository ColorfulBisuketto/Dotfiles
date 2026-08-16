-- Contains all generic variables

local uwsmWrap = "uwsm app -- "
local terminal = uwsmWrap .. "ghostty "
local fileManager = terminal .. "+new-window -e yazi"
local mainMonitorDesc = "desc:AU Optronics 0x4B9D"
local secondaryMonitorDesc = "desc:AOC 2590G5 0x00011A24"
local workspaces = { 10, 1, 2, 3, 4, 5, 6, 7, 8, 9 }

local variables = {
	uwsmWrap = uwsmWrap,
	terminal = terminal,
	fileManager = fileManager,
	mainMonitorDesc = mainMonitorDesc,
	secondaryMonitorDesc = secondaryMonitorDesc,
	workspaces = workspaces,
}

return variables
