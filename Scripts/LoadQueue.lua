QueueManagement = {}
QueueManagement.__index = QueueManagement

function QueueManagement.LoadQueue()
	if table.getn(Item.LoadQueue) > 0 then Item.LoadFromQueue() end
end
