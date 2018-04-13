CharacterClass = {}
CharacterClass.__index = CharacterClass

function CharacterClass:loadSprites()
	for i = 1,40 do
		self.CharSpt[i] = love.graphics.newImage('Graphics/Dev Files/Personagem ('..i..').png')
	end
end

function CharacterClass:moveCharacter(dt)
	local direction = self.OverMove
	local ended = false
	if direction == 'up' then self:moveCharUp(dt)
	elseif direction == 'down' then self:moveCharDown(dt)
	elseif direction == 'left' then self:moveCharLeft(dt)
	elseif direction == 'right' then self:moveCharRight(dt) end
end

function CharacterClass:MoveRandomSquare()
	local direction = math.random(1,4)
	local initial = direction
	local directions = {{0,1,"down"},{1,0,"right"},{0,-1,"up"},{-1,0,"left"}}
	
	while not CanNPCMove(self:RelativeCharacterCoordinates(directions[direction][1], directions[direction][2])) do
		direction = direction % 4
		direction = direction + 1
		if direction == initial then
			return
		end
	end
	
	self:MoveSquare(directions[direction][3])
end

function CharacterClass:MoveSquare(direction)
	local directions = {
		down = {1,0,1}, 
		right = {2,1,0}, 
		up = {3,0,-1}, 
		left = {4,-1,0}
	}
	
	Map.CharacterPos[self.Pygrid + 1][self.Pxgrid] = nil
	Map.CharacterPos[self.Pygrid + 1 + directions[direction][3]][self.Pxgrid + directions[direction][2]] = self
	self.Facing = directions[direction][1]
	self.OverMove = direction
end

function CharacterClass:DrawCharacterFull(x, y)
	love.graphics.draw(CharHair[self.hair][1], x, y)
	love.graphics.draw(CharCBot[self.clothesBot], x, y)
	love.graphics.draw(CharFace[self.face], x, y)
	love.graphics.draw(CharCTop[self.clothesTop], x, y)
	love.graphics.draw(CharHair[self.hair][0], x, y)
end

function PortraitRectangle()
   love.graphics.rectangle("fill", 106, 856, 334, 338)
end

function CharacterClass:DrawCharacterPortrait(x,y)
	love.graphics.stencil(PortraitRectangle, "replace", 1)
	love.graphics.setStencilTest("greater", 0)
			
	love.graphics.draw(CharHair[self.hair][1], x, y)
	love.graphics.draw(CharCBot[self.clothesBot], x, y)
	love.graphics.draw(CharFace[self.face], x, y)
	love.graphics.draw(CharCTop[self.clothesTop], x, y)
	love.graphics.draw(CharHair[self.hair][0], x, y)
	
	love.graphics.setStencilTest()
end

function CharacterClass:SetCharacterPosition(Px, Py)
	
	if Map.CharacterPos[self.Pygrid + 1][self.Pxgrid] then
		Map.CharacterPos[self.Pygrid + 1][self.Pxgrid] = nil
	end
	
	self.Pxgrid = Px
	self.Pygrid = Py
	self.Px=Px*40-40
	self.Py=Py*40-40
	Map.CharacterPos[self.Pygrid + 1][self.Pxgrid] = self
end

function CharacterClass:DoneMoving()
	if self ~= Player then
		self.Timer = 0
		self.TimerLimit = math.random()*5
	else
		local coord = {x=Player.Pxgrid, y=Player.Pygrid+1}
		local event = EventClass.getEvent(coord)
		if event then
			if event.method == "Walk" then 
				event:beginEvent() 
				if event.single then EventClass.lockEvent(coord) end
			end
		end
	end
	
	local path = self.Path or {}
	if self.Path and table.getn(path) == 0 then
		EventClass.triggerEvent() 
		self.Path = nil
		if self == Player then MyLib.lockControls = false end
	end
end

function CharacterClass:moveCharUp(dt)
	self.Py=self.Py-self.Speed*dt*20
	if math.ceil((40+self.Py)/40) ~= self.Pygrid then
		self.OverMove = 'none'
		self.Pygrid=self.Pygrid-1
		self.Py = self.Pygrid*40-40
		self:DoneMoving()
	end
	
	if self == Player then
		Camera:SetCameraYPosition(self)
	end
end

function CharacterClass:moveCharDown(dt)
	self.Py=self.Py+self.Speed*dt*20
	if math.floor((40+self.Py)/40) ~= self.Pygrid then
		self.OverMove = 'none'
		self.Pygrid=self.Pygrid+1
		self.Py = self.Pygrid*40-40
		self:DoneMoving()
	end
	
	if self == Player then
		Camera:SetCameraYPosition(self)
	end
end

function CharacterClass:moveCharLeft(dt)
	self.Px=self.Px-self.Speed*dt*20
	if math.ceil((40+self.Px)/40) ~= self.Pxgrid then
		self.OverMove = 'none'
		self.Pxgrid=self.Pxgrid-1
		self.Px = self.Pxgrid*40-40
		self:DoneMoving()
	end
	
	if self == Player then
		Camera:SetCameraXPosition(self)
	end
end

function CharacterClass:moveCharRight(dt)
	self.Px=self.Px+self.Speed*dt*20
	if math.floor((40+self.Px)/40) ~= self.Pxgrid then
		self.OverMove = 'none'
		self.Pxgrid=self.Pxgrid+1
		self.Px = self.Pxgrid*40-40
		self:DoneMoving()
	end
	
	if self == Player then
		Camera:SetCameraXPosition(self)
	end
end

function CharacterClass:InFrontOf()
	local Id
	
	if self.Facing == 1 then
		Id=self:RelativeCharacterPosition(0,1)
	elseif self.Facing == 2 then
		Id=self:RelativeCharacterPosition(1,0)
	elseif self.Facing == 3 then
		Id=self:RelativeCharacterPosition(0,-1)
	elseif self.Facing == 4 then
		Id=self:RelativeCharacterPosition(-1,0)
	end
	
	if Id:find("E") ~= nil then
		return "-1"
	end
		
	if Id == "0" and self:RelativeCharacterPosition():find("W") ~= nil then
		Id = self:RelativeCharacterPosition()
	end
			
	return Utils.CleanCheckID(Id)
end

function CharacterClass:InFrontOfCoordinates()	
	if self.Facing == 1 then
		coord=self:RelativeCharacterCoordinates(0,1)
	elseif self.Facing == 2 then
		coord=self:RelativeCharacterCoordinates(1,0)
	elseif self.Facing == 3 then
		coord=self:RelativeCharacterCoordinates(0,-1)
	elseif self.Facing == 4 then
		coord=self:RelativeCharacterCoordinates(-1,0)
	end
	
	return coord
end

function CharacterClass:RelativeCharacterPosition(x,y)
	local x = x or 0
	local y = y or 0
	local coordinates = self:RelativeCharacterCoordinates(x,y)
	return Map[coordinates.y][coordinates.x]
end

function CharacterClass:RelativeCharacterCoordinates(x,y)
	local x = x or 0
	local y = y or 0
	
	x = x + self.Pxgrid
	y = y + self.Pygrid + 1
	return {x = x, y = y}
end

function CharacterClass:GetFrame()
	local frame = ((self.Px % 40 + self.Py % 40)/4) - (((self.Px % 40 + self.Py % 40)/4) %1)
	frame = frame + 1 + (self.Facing-1)*10
	return frame
end

function CharacterClass:MoveToSpot(x,y)
	MyLib.lockControls = true
	self.Path = PathFindingAStar(self.Pxgrid, self.Pygrid+1, x, y)
	if self.Path then table.remove(self.Path, endtb) end
end

function CharacterClass:followPath()
	local path = self.Path or {}
	local endtb = table.getn(path)
	
	if endtb > 0 and self.OverMove == "none" then
		if path[endtb].x < self.Pxgrid then
			self.Facing = 4
			self.OverMove = 'left'
		elseif path[endtb].x > self.Pxgrid then
			self.Facing = 2
			self.OverMove = 'right'
		elseif path[endtb].y < self.Pygrid+1 then
			self.Facing = 3
			self.OverMove = 'up'
		elseif path[endtb].y > self.Pygrid+1 then
			self.Facing = 1
			self.OverMove = 'down'
		end
		table.remove(path, endtb)
	end
end