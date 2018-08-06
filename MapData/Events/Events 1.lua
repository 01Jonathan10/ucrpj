return {
	[1] = {
		id = 1,
		method = "Check",
		single = true,
		queue = { 
			function() 
				local content = {{value="Essa é uma máquina de doces"}, 
								 {value="Já que ainda não tem mecânicas de dinheiro, eu vou pegar um..."},
								}
				GameController.player:StartDialog(content)
			end,
			function() 
				GameController.player:GainItem(2,1)
				EventClass.triggerEvent()
			end,
			function() 
				local content = {{value="Hmm, nem sei o sabor, vou guardar pra depois."}}
				GameController.player:StartDialog(content)
			end,
		}
	},
	[2] = {
		id = 2,
		method = "Walk",
		single = true,
		queue = { 
			function() 
				local content = {{value="Urgh, que nojo."}}
				GameController.player:StartDialog(content)
			end,
			function() 
				GameController.player.Speed = 15
				GameController.player:MoveToSpot(12,10)
			end,
			function() 
				local content = {{value="Aquele lugar é um chiqueiro..."}}
				GameController.player:StartDialog(content)
			end,
		}
	},
}
