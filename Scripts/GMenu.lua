GMenu = {}
GMenu.__index = GMenu

require ('GSubmenuScripts')
require ('GSubmenuDraw')
require ('GSubmenuKeypress')

function GMenu.build()

	local menu = {
		option = 1,
		submenu = Constants.EnumInGameSubmenu.MAIN,
	}
	
	setmetatable(menu, GMenu)
	menu:load_imgs()
	
	return menu
end


function GMenu:open_menu()
	local _,_,mode = love.window.getMode()
	self.full_screen = mode.fullscreen
	GameController.world.state = Constants.EnumWorldState.MENU
end


function GMenu:close_menu()
	GameController.world.state = Constants.EnumWorldState.ROAMING
end

function GMenu:load_imgs()
	self.images = {
		select_img = love.graphics.newImage('Graphics/Misc/Selecao.png'),
		SideMenu = love.graphics.newImage('Graphics/Dev Files/SideMenu.png'),
		SideMenub = love.graphics.newImage('Graphics/Dev Files/SideMenu2.png'),
		SideMenuS = love.graphics.newImage('Graphics/Dev Files/SideMenuS.png'),
	}
		
	local i = 1
	while love.filesystem.exists('Graphics/Misc/GMenu '..i..'.png') do
		self.images[i] = love.graphics.newImage('Graphics/Misc/GMenu '..i..'.png')
		i = i + 1
	end
end


function GMenu:update(dt)
	if self.submenu ~= Constants.EnumInGameSubmenu.MAIN then
		self:submenu_update(dt)
	end
end

function GMenu:keypress()
	if self.submenu ~= Constants.EnumInGameSubmenu.MAIN then
		self:submenu_keypress()
	else
		if MyLib.key_list.up and self.option>3 then
			self.option=self.option - 3
		elseif MyLib.key_list.down and self.option<4 then
			self.option=self.option + 3
		elseif MyLib.key_list.right and self.option % 3 ~= 0 then
			self.option=self.option + 1 
		elseif MyLib.key_list.left and self.option % 3 ~= 1 then
			self.option=self.option - 1
		elseif MyLib.key_list.confirm then
			if self.option == 6 then
				DataManager.save(GameController.player)
				MyLib.FadeToColor(0.3,{"LuaCall>GameController.begin_game()"},{},"fill",{0,0,0,255},true)
			else
				self.submenu = self.option
				self.option = 1
			end
			
			-- TODO: Outros Menus
		end
	end
end

function GMenu:draw(dt)
	if self.submenu ~= Constants.EnumInGameSubmenu.MAIN then
		self:submenu_draw()
	else
		ViewClass.draw(self.images.SideMenu, 800, 0)
		ViewClass.draw(self.images.SideMenub, 800, 0)
		local Xmenu =((self.option-1)%3)*206 + 980
		local Ymenu =(((self.option-1)/3)-((self.option-1)/3)%1)*220 + 450
		ViewClass.draw(self.images.SideMenuS,Xmenu,Ymenu)
		ViewClass.print("Day "..GameController.player.Day.." - "..string.format("%02d",GameController.player.Time[1])..":"..string.format("%02d",GameController.player.Time[2]), 880, 120)
	end
end
