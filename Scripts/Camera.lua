Camera = {}
Camera.__index = Camera

function Camera.setup()
	local camera = {}
	
	camera = {
		Xcam = 0,
		Ycam = 0,
		DestX = 0,
		DestY = 0,
		Speed = 300
	}
	
	setmetatable(camera,Camera)

	return camera
end

function Camera:Stop()
	self.DestX = self.Xcam
	self.DestY = self.Ycam
end

function Camera:setCameraPosition(character)

	self:SetCameraXPosition(character)
	self:SetCameraYPosition(character)
	
end

function Camera:SetCameraXPosition(character)
	local map = MapClass.get_active()
	if map.Xmax <= 20 then
		self.DestX = (map.Xmax - 20)*40
	else
		self.DestX = math.max(View.XOri, 2*(character.Px-380))
		self.DestX = math.min((((map.Xmax * 80 * View.Scale) - View.SX)/View.Scale + View.XOri), self.DestX)
	end
end

function Camera:SetCameraYPosition(character)
	local map = MapClass.get_active()
	if map.Ymax <= 15 then
		self.DestY = (map.Ymax - 15)*40
	else
		self.DestY = math.max(View.YOri, 2*(character.Py-240))
		self.DestY = math.min((((map.Ymax * 80 * View.Scale) - View.SY)/View.Scale + View.YOri), self.DestY)
	end
end

function Camera:setForceCameraPosition(character)
	local map = MapClass.get_active()
	if map.Ymax <= 15 then
		self.Ycam = (map.Ymax - 15)*40
	else
		self.Ycam = math.max(View.YOri, 2*(character.Py-240))
		self.Ycam = math.min((((map.Ymax * 80 * View.Scale) - View.SY)/View.Scale + View.YOri), self.Ycam)
	end
	
	if map.Xmax <= 20 then
		self.Xcam = (map.Xmax - 20)*40
	else
		self.Xcam = math.max(View.XOri, 2*(character.Px-380))
		self.Xcam = math.min((((map.Xmax * 80 * View.Scale) - View.SX)/View.Scale + View.XOri), self.Xcam)
	end
	
	self:Stop()
end

function Camera:UpdateCamera(dt)
	if math.abs(self.Xcam - self.DestX) < 5 then
		self.Xcam = self.DestX
	elseif self.Xcam < self.DestX then
		self.Xcam = self.Xcam + dt * self.Speed
	elseif self.Xcam > self.DestX then
		self.Xcam = self.Xcam - dt * self.Speed
	end
	
	if math.abs(self.Ycam - self.DestY) < 5 then
		self.Ycam = self.DestY
	elseif self.Ycam < self.DestY then
		self.Ycam = self.Ycam + dt * self.Speed
	elseif self.Ycam > self.DestY then
		self.Ycam = self.Ycam - dt * self.Speed
	end
end
