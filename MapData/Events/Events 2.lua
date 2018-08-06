return {
	[1] = {
		id = 3,
		method = "Walk",
		single = true,
		queue = { 
			function() 
				local sophie = NPC.create({
					name = "Sophie Emanuelle",
					Id = "Sp_1",
					Px = 32, Py = 10,

					looks = {
						Hair = 1,
						CBot = 1,
						Face = 2,
						CTop = 1,	
					},
				})
				local content = {{value="Eeeeei!", characterId = sophie.Id}}
				GameController.player:StartDialog(content)
			end,
			function() 
				GameController.player.Facing = 2
				local sophie = GetCharacterById("Sp_1")
				sophie.Speed = 10
				sophie:MoveToSpot(GameController.player.Pxgrid + 1,GameController.player.Pygrid + 1)
			end,
			function() 
				local sophie = GetCharacterById("Sp_1")
				sophie.Speed = 5
				local content = {{value="Olha só! Funcionou XD", characterId = sophie.Id},
								 {value="Agora só faltam mais ...", characterId = sophie.Id},
								 {value="142 cards do Trello pra resolver", characterId = sophie.Id},
								 {value="..."},
								 {value="Quê."}
								}
				GameController.player:StartDialog(content)
			end,
		}
	},
	[2] = {
		id = 4,
		method = "Walk",
		single = false,
		queue = { 
			function() 
				local content = {{value="É, eu não assisti aula nenhuma..."},
								 {value="Principalmente porque não tem aula ainda nesse jogo"},
								 {value="E nem tem como eu sair desse mapa."},
								 {value="Mas parece que aqui vai ser o dormitório depois, então..."},
								 {value="Acho que eu vou dormir"}
								}
				GameController.player:StartDialog(content)
			end,
			function()
				MyLib.FadeToColor(1, {"LuaCall>EventClass.triggerEvent()"}, {}, "fill", {0,0,0,255}, true)
			end,
			function()
				GameController.player.Day = GameController.player.Day + 1
				GameController.player.Time = {6,0}
				GameController.player:MoveToSpot(GameController.player.Pxgrid + 3,GameController.player.Pygrid + 1)
			end,
			function() 
				local content = {{value="E assim, começamos um novo dia."},
								 {value="Eu espero..."}
								}
				GameController.player:StartDialog(content)
			end,
		}
	},
	[3] = {
		id = 5,
		method = "Walk",
		single = false,
		queue = { 
			function() 
				local content = {{value="..."}}
				GameController.player:StartDialog(content)
			end,
			function()
				GameController.player.Facing = 3
				GameController.player:Wait(1)
			end,
			function()
				GameController.player.Facing = 2
				GameController.player:Wait(1)
			end,
			function()
				GameController.player.Facing = 3
				GameController.player:Wait(1)
			end,
			function()
				local content = {{value="Medo... Acho que eu ouvi alguma coisa."}}
				GameController.player:StartDialog(content)
			end,
		}
	},
}
