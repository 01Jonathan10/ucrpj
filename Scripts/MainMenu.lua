MainMenu = {}
MainMenu.__index = MainMenu

require ('MainMenu_SubmenuDraw')
require ('MainMenu_SubmenuKeyPress')
require ('MainMenu_SubmenuScripts')

function MainMenu.new()
	local _,_,mode = love.window.getMode()
		
	local menu = {
		submenu = Constants.EnumMainSubmenu.MAIN, 
		option = 1,
		state = Constants.EnumMenuState.NORMAL,
		MasterV = 100*love.audio.getVolume(),
		FullScreen = mode.fullscreen,
		LoadQueue = 0,
	}
	
	setmetatable(menu, MainMenu)
	menu:load_imgs()
	
	return menu
end


function MainMenu:load_imgs()
	self.images = {
		select_img = love.graphics.newImage('Graphics/Misc/Selecao.png'),
	}
		
	local i = 0
	while love.filesystem.exists('Graphics/Misc/Menu '..i..'.png') do
		self.images[i] = love.graphics.newImage('Graphics/Misc/Menu '..i..'.png')
		i = i + 1
	end
end

function MainMenu:back_to_main(option)
	local _,_,mode = love.window.getMode()
	local option = option or 1
	self.option = option
	self.state = Constants.EnumMenuState.NORMAL
	self.MasterV = 100*love.audio.getVolume()
	self.FullScreen = mode.fullscreen
end

function MainMenu:draw()
	ViewClass.draw(self.images[self.submenu], -800, 0)
	self:draw_submenu()
end

function MainMenu:update(dt)
	self:update_submenu(dt)
end

function MainMenu:keypress(dt)
	self:keypress_submenu(dt)
end
