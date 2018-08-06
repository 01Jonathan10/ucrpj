QueueManager = {queues = {}}
QueueManager.__index = QueueManager

function QueueManager.load()
	QueueManager.is_loading = true
	
	if GameController.menu.load_queue then GameController.menu:load_from_queue()
	elseif table.getn(Item.LoadQueue) > 0 then Item.LoadFromQueue()
	elseif table.getn(MapClass.LoadQueue) > 0 then MapClass.LoadFromQueue()
	else QueueManager.is_loading = false end
end

function MainMenu:load_from_queue()
	local id = math.floor(self.load_queue/4) + 1
	local iter = self.load_queue % 4 + 1
	
	self.load_queue = self.load_queue + 1
	
	if iter == 1 and love.filesystem.exists('Graphics/Chars/Hair/Hair_'..id..'_F.png') then
		self.CharImg.looks.Hair[id] = {}
		self.CharImg.looks.Hair[id][0] = love.graphics.newImage('Graphics/Chars/Hair/Hair_'..id..'_F.png')
		self.CharImg.looks.Hair[id][1] = love.graphics.newImage('Graphics/Chars/Hair/Hair_'..id..'_B.png')
	elseif iter == 2 and love.filesystem.exists('Graphics/Chars/CTop/CTop_'..id..'.png') then
		self.CharImg.looks.CTop[id] = love.graphics.newImage('Graphics/Chars/CTop/CTop_'..id..'.png')
	elseif iter == 3 and love.filesystem.exists('Graphics/Chars/CBot/CBot_'..id..'.png') then
		self.CharImg.looks.CBot[id] = love.graphics.newImage('Graphics/Chars/CBot/CBot_'..id..'.png')
	elseif iter == 4 and love.filesystem.exists('Graphics/Chars/Face/Face_'..id..'.png') then
		self.CharImg.looks.Face[id] = love.graphics.newImage('Graphics/Chars/Face/Face_'..id..'.png')
	else
		self.load_queue = nil
	end
end
