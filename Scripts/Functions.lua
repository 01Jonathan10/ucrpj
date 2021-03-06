require ('Functions_Characters')

function loadDialogs()
	local mood = 1
	local dialog_id = 1
	local lineId = 1
	TextData.SmallTalk = {}
	while love.filesystem.exists('TextData/RandomNPCDialog/SmallTalk_'..mood..'.txt') do
		TextData.SmallTalk[mood] = {}
		TextData.SmallTalk[mood][1] = {}
		for line in love.filesystem.lines('TextData/RandomNPCDialog/SmallTalk_'..mood..'.txt') do
			if line == "--" then
				dialog_id = dialog_id + 1
				lineId = 1
				TextData.SmallTalk[mood][dialog_id] = {}
			else
				TextData.SmallTalk[mood][dialog_id][lineId] = {value = string.sub(line, 6)}
				if not (line:sub(1,1) == '1') then
					TextData.SmallTalk[mood][dialog_id][lineId].characterId = (line:sub(1,1))
				end
				TextData.SmallTalk[mood][dialog_id][lineId+1] = nil
				lineId = lineId + 1
			end
		end
		lineId = 1
		mood = mood + 1
	end
end

function setDrawSize()
	love.graphics.scale(View.Scale, View.Scale)
	love.graphics.translate(View.XOri, View.YOri)
end

function PathFindingAStar(XStart, YStart, XGoal, YGoal)
	local PathMap = {}
	for i=1,Map.Ymax do
		PathMap[i] = {}
		for j=1,Map.Xmax do
			PathMap[i][j] = {}
		end
	end
	
	PathMap[YStart][XStart] = {x=XStart,y=YStart, GCost = 0, cameFrom = nil}
	
	local start = PathMap[YStart][XStart]
	local goal = {x=XGoal,y=YGoal}
	
	local openSet = {start}
	local closedSet = {}
	
	local current = nil
	local currentKey = nil
	local smallest = 0
	
    while table.getn(openSet) > 0 do
		smallest = 500
		for key, each in pairs(openSet) do
			if each.GCost < smallest then
				smallest = each.GCost
				current = each
				currentKey = key
			end
		end
		        
		if current.x == goal.x and current.y == goal.y then
            return reconstructPath(current)
		end

        table.remove(openSet, currentKey)
		current.checked = true

		local neighbors = getNeighbors(current)

        for _, neighbor in pairs(neighbors) do
            
			if not (PathMap[neighbor.y][neighbor.x].checked) then				
				
				if not PathMap[neighbor.y][neighbor.x].GCost then
					PathMap[neighbor.y][neighbor.x] = neighbor
					table.insert(openSet, PathMap[neighbor.y][neighbor.x])
				end
				
				if PathMap[neighbor.y][neighbor.x].GCost > neighbor.GCost then
					PathMap[neighbor.y][neighbor.x] = neighbor
				end
			end
		end
	end
	
    return nil
end

function reconstructPath(current)
    local total_path = {}
    
	while current do
		table.insert(total_path, current)
        current = current.cameFrom
	end
	
    return total_path
end

function getNeighbors(node)
	local neighbors = {}
	if node.x > 1 then
		if CanMove({x=node.x-1, y=node.y}) then table.insert(neighbors, {x=node.x-1,y=node.y, GCost = node.GCost + 1, cameFrom = node}) end
	end
	if node.x < Map.Xmax then
		if CanMove({x=node.x+1, y=node.y}) then table.insert(neighbors, {x=node.x+1,y=node.y, GCost = node.GCost + 1, cameFrom = node}) end
	end
	if node.y > 1 then
		if CanMove({x=node.x, y=node.y-1}) then table.insert(neighbors, {x=node.x,y=node.y-1, GCost = node.GCost + 1, cameFrom = node}) end
	end
	if node.y < Map.Ymax then
		if CanMove({x=node.x, y=node.y+1}) then table.insert(neighbors, {x=node.x,y=node.y+1, GCost = node.GCost + 1, cameFrom = node}) end
	end
	return neighbors
end

function ToggleFullScreen(FS)

	if FS then
		love.window.setMode(1920, 1080, {fullscreen = true})
	else
		love.window.setMode(800, 600, {fullscreen = false})
	end

	local DrawSize = 0.5
	local XOri, YOri, SXSc, SYSc = 0, 0, 0.5, 0.5

	View.SX, View.SY = love.graphics.getDimensions()
	SXSc = View.SX / 1600
	SYSc = View.SY / 1200
	DrawSize = math.min(SXSc, SYSc)
	if SXSc == DrawSize then
		YOri = (View.SY - 600) / 2
	else
		XOri = (View.SX - 800) / 2
	end

	View.Scale =  DrawSize
	View.XOri = XOri
	View.YOri = YOri
	
	if View.camera then 
		View.camera:setForceCameraPosition(GameController.player)
	end
end
