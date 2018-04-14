function love.load(arg)		
	GMenuImg = {}
	loadImages(GMenuImg, 'Graphics/Misc/GMenu ', '.png')
		
	FloorTl = love.graphics.newImage('Graphics/Dev Files/Tile test 1.png')
	DialogBox = love.graphics.newImage('Graphics/Dev Files/Dialogbox.png')
	SideMenu = love.graphics.newImage('Graphics/Dev Files/SideMenu.png')
	SideMenub = love.graphics.newImage('Graphics/Dev Files/SideMenu2.png')
	SideMenuS = love.graphics.newImage('Graphics/Dev Files/SideMenuS.png')
	
end

function loadImages(Tb, prefix,suffix)
	local i = 1
	while love.filesystem.exists(prefix..i..suffix) do
		Tb[i] = love.graphics.newImage(prefix..i..suffix)
		i = i + 1
	end
end