MyLib.lockControls = false

function MyLib.MyLibSetup()
	local loveUpdate = love.update
	love.update = function(dt)
		MyLib.ApplyFades(dt)
		loveUpdate(dt)
		MyLib.KeyRefresh()
	end

	local loveDraw = love.draw
	love.draw = function(dt)
		loveDraw(dt)
		MyLib.DrawFades()
	end

	local loveKeyPress = love.keypressed
	love.keypressed = function(key)
		if MyLib.lockControls then
			return
		end
		KeyList = MyLib.KeyPress(key)
		loveKeyPress(key)
	end

	local loveMousePress = love.mousepressed
	love.mousepressed = function(X, Y, K)
		if MyLib.lockControls then
			return
		end
		loveMousePress(X, Y, K)
	end

	local loveTextInput = love.textinput
	love.textinput = function(text)
		if MyLib.lockControls then
			return
		end
		loveTextInput(text)
	end
end