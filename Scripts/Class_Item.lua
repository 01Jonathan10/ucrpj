Item = {}
Item.__index = Item

ItemData = {}
Item.LoadQueue = {}

function Item:create(Id, Name, Desc)
	local item = { 
		ID = Id,
		Name = Name,
		Description = Desc,
	}
		
	setmetatable(item,Item)
	
	ItemData[Id] = item
	
	Item.LoadQueue[table.getn(Item.LoadQueue) + 1] = item

	return item
end

function Item.LoadFromQueue()
	item = table.remove(Item.LoadQueue, 1)
	item.Img = love.graphics.newImage('Graphics/Items/Photos/Item '..item.ID..'.png')
	item.Sprite = love.graphics.newImage('Graphics/Items/Sprites/Item '..item.ID..'.png')
end

function Item.LoadItems()
	local items = love.filesystem.load('TextData/ItemData/Items.lua')()
	local descs = love.filesystem.load('TextData/ItemData/ItemsDescriptions.lua')()
	for _, item in pairs(items) do
		Item:create(item.ID, item.Name, descs[item.ID])
	end
end
