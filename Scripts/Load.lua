function love.load(arg)	
    Selecao = love.graphics.newImage('Graphics/Misc/Selecao.png')
	
	MenuImg = {}
	
	GMenuImg = {}
	loadImages(GMenuImg, 'Graphics/Misc/GMenu ', '.png')
	
	local i = 0
	while love.filesystem.exists('Graphics/Misc/Menu '..i..'.png') do
		MenuImg[i] = love.graphics.newImage('Graphics/Misc/Menu '..i..'.png')
		i = i + 1
	end
	
	CredImg = love.graphics.newImage('Graphics/Misc/Credits.png')

	FloorTl = love.graphics.newImage('Graphics/Dev Files/Tile test 1.png')
	DialogBox = love.graphics.newImage('Graphics/Dev Files/Dialogbox.png')
	SideMenu = love.graphics.newImage('Graphics/Dev Files/SideMenu.png')
	SideMenub = love.graphics.newImage('Graphics/Dev Files/SideMenu2.png')
	SideMenuS = love.graphics.newImage('Graphics/Dev Files/SideMenuS.png')
	
	i = 1
	while love.filesystem.exists('Graphics/Chars/Hair/Hair_'..i..'_F.png') do
		CharHair[i] = {}
		CharHair[i][0] = love.graphics.newImage('Graphics/Chars/Hair/Hair_'..i..'_F.png')
		CharHair[i][1] = love.graphics.newImage('Graphics/Chars/Hair/Hair_'..i..'_B.png')
		i = i + 1
	end

	loadImages(CharFace, 'Graphics/Chars/Face/Face_','.png')
	loadImages(CharCTop, 'Graphics/Chars/CTop/CTop_','.png')
	loadImages(CharCBot, 'Graphics/Chars/CBot/CBot_','.png')
	
	SELECT_CUSTOM_LEN = {
		[1] = table.getn(CharHair),
		[2] = table.getn(CharFace),
		[3] = table.getn(CharCTop),
		[4] = table.getn(CharCBot),
	}
end

function loadImages(Tb, prefix,suffix)
	local i = 1
	while love.filesystem.exists(prefix..i..suffix) do
		Tb[i] = love.graphics.newImage(prefix..i..suffix)
		i = i + 1
	end
end