QueueManagement = {}
QueueManagement.__index = QueueManagement

function QueueManagement.LoadQueue()
	local menu = Menu or {}
	
		if menu.LoadQueue then Menu.LoadFromQueue()
	elseif table.getn(Item.LoadQueue) > 0 then Item.LoadFromQueue() end
end
