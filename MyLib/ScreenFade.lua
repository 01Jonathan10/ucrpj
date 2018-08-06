require ('Class_Fade')

function MyLib.FadeToColor(Time, Variables, Values, Type, Color, Mirror)
	MyLib.FadeClass.create(Time, Variables, Values, Type, Color, Mirror)	
end

function MyLib.FadeImg(Time, Variables, Values, InOut, Img, X, Y)
	MyLib.FadeClass.create(Time, Variables, Values, "Img", Img, Inout, X, Y)	
end

function MyLib.DrawFades()

	love.graphics.translate(-800,0)

	local fade

	for _, fade in pairs(MyLib.Fades) do
		fade:draw()
	end
	
	love.graphics.setColor(255, 255, 255, 255)
	
	love.graphics.translate(800,0)
	
end

function MyLib.ApplyFades(dt)
	for _, fade in pairs(MyLib.Fades) do
		fade:update(dt)
	end
end
