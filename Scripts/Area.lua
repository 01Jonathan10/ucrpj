Area = {}
Area.__index = Area

function Area.create(id, origin_map, origin_coord)
	local area = {
		id = id,
		maps = {},
		origin_coord = origin_coord,
		NPCs = {}
	}
		
	for _, map_no in pairs(love.filesystem.load('MapData/Areas/Area_'..area.id..'.lua')()) do
		area.maps[map_no] = MapClass.create(map_no, area)
	end
	
	setmetatable(area,Area)
	
	GameController.world.area = area
	area.maps[origin_map]:load_map()
	
	return area
end

function Area:set_coord(origin)
	if origin then
		GameController.player:SetCharacterPosition(origin[1], origin[2])
	end
end

function Area:done_loading()
	MyLib.FadeToColor(0.3,{"LuaCall>MyLib.lock_controls=false", "LuaCall>GameController.player:DoneMoving()"},{},"fill",{0,0,0,255},false)
	self:set_coord(GameController.world.area.origin_coord)
	self.origin_coord = nil
	View.camera:setForceCameraPosition(GameController.player)
	GameController.world.loading = false
	GameController.world.state = Constants.EnumWorldState.ROAMING
	GameController.player:DoneMoving()
end
