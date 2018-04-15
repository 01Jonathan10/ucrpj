CameraClass = {}
CameraClass.__index = CameraClass

function CameraClass.setup()
	local camera = {}
	
	camera = {
		Xcam = 0,
		Ycam = 0,
		DestX = 0,
		DestY = 0,
		Speed = 300,
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
		self.DestX = (Map.Xmax - 20)*40
	else
		self.DestX = math.max(View.XOri, 2*(Character.Px-380))
		self.DestX = math.min((((Map.Xmax * 80 * View.Scale) - View.SX)/View.Scale + View.XOri), self.DestX)
	end
end

function CameraClass:SetCameraYPosition(Character)
	if Map.Ymax <= 15 then
		self.DestY = (Map.Ymax - 15)*40
	else
		self.DestY = math.max(View.YOri, 2*(Character.Py-240))
		self.DestY = math.min((((Map.Ymax * 80 * View.Scale) - View.SY)/View.Scale + View.YOri), self.DestY)
	end
end

function CameraClass:setForceCameraPosition(Character)
	if Map.Ymax <= 15 then
		self.Ycam = (Map.Ymax - 15)*40
	else
		self.Ycam = math.max(View.YOri, 2*(Character.Py-240))
		self.Ycam = math.min((((Map.Ymax * 80 * View.Scale) - View.SY)/View.Scale + View.YOri), self.Ycam)
	end
	
	if Map.Xmax <= 20 then
		self.Xcam = (Map.Xmax - 20)*40
	else
		self.Xcam = math.max(View.XOri, 2*(Character.Px-380))
		self.Xcam = math.min((((Map.Xmax * 80 * View.Scale) - View.SX)/View.Scale + View.XOri), self.Xcam)
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
