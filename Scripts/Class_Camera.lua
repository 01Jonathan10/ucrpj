CameraClass = {}
CameraClass.__index = CameraClass

function CameraClass.setup()
	local camera = {}
	
	camera = {
		Xcam = 0,
		Ycam = 0,
		DestX = 0,
		DestY = 0,
		Speed = 150,
	}
	
	setmetatable(camera,CameraClass)

	return camera
end

function CameraClass:Stop()
	self.DestX = self.Xcam
	self.DestY = self.Ycam
end

function CameraClass:setCameraPosition(Character)

	self:SetCameraXPosition(Character)
	self:SetCameraYPosition(Character)
	
end

function CameraClass:SetCameraXPosition(Character)
	if Map.Xmax <= 20 then
		self.DestX = (21 - Map.Xmax)*20
	else
		self.DestX = math.min(0,380-Character.Px)
		self.DestX = math.max(840-(Map.Xmax*40),self.DestX)
	end
end

function CameraClass:SetCameraYPosition(Character)
	if Map.Ymax <= 15 then
		self.DestY = (15 - Map.Ymax)*20
	else
		self.DestY = math.min(0,240-Character.Py)
		self.DestY = math.max(600-(Map.Ymax*40),self.DestY)
	end
end

function CameraClass:setForceCameraPosition(Character)
	if Map.Ymax <= 15 then
		self.Ycam = (15 - Map.Ymax)*20
	else
		self.Ycam = math.min(0,240-Character.Py)
		self.Ycam = math.max(600-(Map.Ymax*40),self.Ycam)
	end
	
	if Map.Xmax <= 20 then
		self.Xcam = (21 - Map.Xmax)*20
	else
		self.Xcam = math.min(0,380-Character.Px)
		self.Xcam = math.max(840-(Map.Xmax*40),self.Xcam)
	end
	
	self:Stop()
end

function CameraClass:UpdateCamera(dt)
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
