return {
	{'E1',1,8,12},
	{'E2',1,8,13},
	{'V1',12,11},
	{'V1',13,11},
	{'V2',1,13},
	{'V2',1,14},
	{'V2',1,15},
	{'V3',2,16},
	{'V3',2,17},
	
	{'Character',
		{
			name = "Sophie Emanuelle",
			Id = "Sp_1",
			Px = 14, Py = 10,

			looks = {
				Hair = 1,
				CBot = 1,
				Face = 2,
				CTop = 1,	
			},
		},
		function() return GameController.player.ClearedEvents[3] end
	}
}