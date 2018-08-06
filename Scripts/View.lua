ViewClass = {}

function ViewClass.toggle_full_screen(full_screen)
	-- TODO: Fix this Shit
	if full_screen then
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

function ViewClass.draw(...)
	local params = {...}
	love.graphics.draw(unpack(params))
end

function ViewClass.print(...)
	local params = {...}
	love.graphics.print(unpack(params))
end

function ViewClass.printf(...)
	local params = {...}
	love.graphics.printf(unpack(params))
end

function ViewClass.rectangle(...)
	local params = {...}
	love.graphics.rectangle(unpack(params))
end
