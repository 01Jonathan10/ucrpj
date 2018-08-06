MyLib.FadeClass = {}
MyLib.FadeClass.__index = MyLib.FadeClass
MyLib.FadeClass.Last_Id = 0

MyLib.Fades = {}

function MyLib.FadeClass.create(Time, Variables, Values, Type, Fill, Mirror, X, Y)	
	local new_fade = {}
	
	local X = X or nil
	local Y = Y or nil
	MyLib.FadeClass.Last_Id = MyLib.FadeClass.Last_Id + 1
	
	new_fade = {
		Time = Time,
		Variables = Variables,
		Values = Values,
		Type = Type,
		Fill = Fill,
		Mirror = Mirror,
		TimeLimit = Time,
		Time = Time,
		X = X,
		Y = Y,
		id = MyLib.FadeClass.Last_Id
	}
	
	setmetatable(new_fade,MyLib.FadeClass)
	
	MyLib.Fades[new_fade.id] = new_fade
	
	return new_fade
end

function MyLib.FadeClass:draw()
	local Color

	if self.Type == "Img" then
		Color = {255,255,255,255}
	else
		Color = {unpack(self.Fill)}
	end
	
	Color[4] = (Color[4]*self.Time)/self.TimeLimit

	if self.Mirror then
		Color[4] = 255 - Color[4]
		love.graphics.setColor(unpack(Color))
	else
		love.graphics.setColor(unpack(Color))
	end
	
	if self.Type == "fill" then
		ViewClass.rectangle("fill", 0, 0, 3200, 1200)
	elseif self.Type == "Img" then
		ViewClass.draw(self.Fill, self.X, self.Y)
	end

end

function MyLib.FadeClass:update(dt)

	self.Time=self.Time - dt
	
	if self.Time<=0 then
		self:resolve()
	end
end

function MyLib.FadeClass:resolve()
	for l, _ in pairs(self.Variables) do
		if self.Variables[l]:sub(1,8) == "LuaCall>" then
			loadstring(self.Variables[l]:sub(9))()
		else
			_G[self.Variables[l]] = self.Values[l]
		end
	end
			
	if self.Mirror and self.Type ~= "Img" then
		MyLib.FadeClass.create(self.TimeLimit,{},{}, self.Type, self.Fill, false)
	end
	
	MyLib.Fades[self.id] = nil
end
