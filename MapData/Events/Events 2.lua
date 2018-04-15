return {
	[1] = {
		id = 3,
		method = "Walk",
		single = true,
		queue = { 
			function() 
				local sophie = NPC.create({
					Name = "Sophie Emanuelle",
					Id = "Sp_1",
					Px = 32, Py = 10,

					Hair = 1,
					CBot = 1,
					Face = 2,
					CTop = 1,					
				})
				local content = {{value="Eeeeei!", characterId = sophie.Id}}
				Player:StartDialog(content)
			end,
			function() 
				Player.Facing = 2
				local sophie = GetCharacterById("Sp_1")
				sophie.Speed = 10
				sophie:MoveToSpot(Player.Pxgrid + 1,Player.Pygrid + 1)
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
				Player:StartDialog(content)
			end,
		}
	},
}
