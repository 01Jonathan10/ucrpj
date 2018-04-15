GMenuClass = {}
GMenuClass.__index = GMenuClass
GMenu = {}

require ('GSubmenuScripts')
require ('GSubmenuDraw')

function GMenuClass.BuildMenu()

	GMenu = {
		SelectMenu = 1,
		Active = false,
	}
	
	setmetatable(GMenu,GMenuClass)
	GMenu:LoadImgs()
end


function GMenuClass:StartMenu()
	self.Active = self.locked ~= true
end


function GMenuClass:CloseMenu()
	self.Active = false
end

function GMenuClass:LoadImgs()
	self.Imgs = {
		Selecao = love.graphics.newImage('Graphics/Misc/Selecao.png'),
		SideMenu = love.graphics.newImage('Graphics/Dev Files/SideMenu.png'),
		SideMenub = love.graphics.newImage('Graphics/Dev Files/SideMenu2.png'),
		SideMenuS = love.graphics.newImage('Graphics/Dev Files/SideMenuS.png'),
	}
		
	local i = 1
	while love.filesystem.exists('Graphics/Misc/GMenu '..i..'.png') do
		self.Imgs[i] = love.graphics.newImage('Graphics/Misc/GMenu '..i..'.png')
		i = i + 1
	end
	print (self.Imgs[2])
end


function GMenuClass:Update(dt)
	if self.Submenu then
		GSubmenuUpdate(dt)
	else
		if KeyList[4] and self.SelectMenu>3 then
			self.SelectMenu=self.SelectMenu - 3
		elseif KeyList[5] and self.SelectMenu<4 then
			self.SelectMenu=self.SelectMenu + 3
		elseif KeyList[7] and self.SelectMenu % 3 ~= 0 then
			self.SelectMenu=self.SelectMenu + 1 
		elseif KeyList[6] and self.SelectMenu % 3 ~= 1 then
			self.SelectMenu=self.SelectMenu - 1
		elseif KeyList[2] then
			if self.SelectMenu == 6 then
				MyLib.FadeToColor(0.3,{"LuaCall>MenuClass.BuildMenu()", "OverW"},{nil,false},"fill",{0,0,0,255},true)
				SaveCharacter(Player)
			else
				self.SubmenuSelect = 1
				self.Submenu = self.SelectMenu
				
				if self.Submenu == 5 then
					self.MasterV = 100*love.audio.getVolume()
					self.VControl = true
				end
			end
			
			-- 4 TODO
			-- 3 Friends
			-- 2 Equip
			-- 1 Inventory

		end
	end
end


function GMenuClass:Draw(dt)
	if self.Submenu then
		GSubmenuDraw()
	else
		love.graphics.draw(self.Imgs.SideMenu, 800, 0)
		love.graphics.draw(self.Imgs.SideMenub, 800, 0)
		local Xmenu =((self.SelectMenu-1)%3)*206 + 980
		local Ymenu =(((self.SelectMenu-1)/3)-((self.SelectMenu-1)/3)%1)*220 + 450
		love.graphics.draw(self.Imgs.SideMenuS,Xmenu,Ymenu)
	end
end
