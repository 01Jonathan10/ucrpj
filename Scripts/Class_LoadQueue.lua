QueueManagement = {}
QueueManagement.__index = QueueManagement

QueueManagement.queues = {}

function QueueManagement.LoadQueue()
	local Menu = Menu or {}
	if Menu.LoadQueue then Menu.LoadFromQueue()
	elseif table.getn(Item.LoadQueue) > 0 then Item.LoadFromQueue() end
end
