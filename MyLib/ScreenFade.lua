MyLib.FadeMatrix = {}

function MyLib.FadeToColor(Time, Variables, Values, Type, Color, Mirror)
	k = table.getn(MyLib.FadeMatrix) + 1
	if k == 20 then
		MyLib.FadeMatrix = {}
		k=1
	end
	MyLib.FadeMatrix[k]={}
	MyLib.FadeMatrix[k].Time = Time
	MyLib.FadeMatrix[k].Variables = Variables
	MyLib.FadeMatrix[k].Values = Values
	MyLib.FadeMatrix[k].Type = Type
	MyLib.FadeMatrix[k].Fill = Color
	MyLib.FadeMatrix[k].Mirror = Mirror
	MyLib.FadeMatrix[k].TimeLimit = Time
	
end

function MyLib.FadeImg(Time, Variables, Values, InOut, Img, X, Y)

	k = table.getn(MyLib.FadeMatrix) + 1
	if k == 20 then
		MyLib.FadeMatrix = {}
		k=1
	end
	MyLib.FadeMatrix[k]={}
	MyLib.FadeMatrix[k].Time = Time
	MyLib.FadeMatrix[k].Variables = Variables
	MyLib.FadeMatrix[k].Values = Values
	MyLib.FadeMatrix[k].Type = "Img"
	MyLib.FadeMatrix[k].Fill = Img
	MyLib.FadeMatrix[k].Mirror = InOut
	MyLib.FadeMatrix[k].TimeLimit = Time
	MyLib.FadeMatrix[k].X = X
	MyLib.FadeMatrix[k].Y = Y
	
end

function MyLib.DrawFades()

	for k, _ in pairs(MyLib.FadeMatrix) do
		love.graphics.translate(-800,0)
		if MyLib.FadeMatrix[k].Time > 0 then
		
			if MyLib.FadeMatrix[k].Type == "Img" then
				Color = {255,255,255,255}
			else
				Color = MyLib.FadeMatrix[k].Fill
			end
			Alpha = (Color[4]*MyLib.FadeMatrix[k].Time)/MyLib.FadeMatrix[k].TimeLimit
			love.graphics.setColor(Color[1], Color[2], Color[3], 255-Alpha)
			if not MyLib.FadeMatrix[k].Mirror then
				love.graphics.setColor(Color[1], Color[2], Color[3], Alpha)
			end
			
			if MyLib.FadeMatrix[k].Type == "fill" then
				love.graphics.rectangle("fill", 0, 0, 3200, 1200)
			elseif MyLib.FadeMatrix[k].Type == "Img" then
				love.graphics.draw(MyLib.FadeMatrix[k].Fill, MyLib.FadeMatrix[k].X, MyLib.FadeMatrix[k].Y)
			end
			
		end
		love.graphics.translate(800,0)
		
	end
	
	love.graphics.setColor(255, 255, 255, 255)
	
end

function MyLib.ends(String,End)
	return End=='' or string.sub(String,-string.len(End))==End
end

function MyLib.ApplyFades(dt)

	for k, _ in pairs(MyLib.FadeMatrix) do
	
		if MyLib.FadeMatrix[k] then
	
			if MyLib.FadeMatrix[k].Time>0 then
				if MyLib.FadeMatrix[k].Type ~= "Img" then
					MyLib.KeyRefresh()
				end
				MyLib.FadeMatrix[k].Time=MyLib.FadeMatrix[k].Time - dt
			end
			
			if MyLib.FadeMatrix[k].Time<=0 and MyLib.FadeMatrix[k].Time>(-9999) then
				MyLib.FadeMatrix[k].Time=0
				
				for l, _ in pairs(MyLib.FadeMatrix[k].Variables) do

					if MyLib.FadeMatrix[k].Variables[l]:sub(1,8) == "LuaCall>" then
						loadstring(MyLib.FadeMatrix[k].Variables[l]:sub(9))()
					else
						_G[MyLib.FadeMatrix[k].Variables[l]] = MyLib.FadeMatrix[k].Values[l]
					end
				end
				
				MyLib.FadeMatrix[k].Time=(-9999)
				
				if MyLib.FadeMatrix[k].Mirror == true then
					if MyLib.FadeMatrix[k].Type ~= "Img" then
						MyLib.FadeToColor(MyLib.FadeMatrix[k].TimeLimit,{},{},MyLib.FadeMatrix[k].Type,MyLib.FadeMatrix[k].Fill,false)
					end
				end
				
			end
		end
	end
end