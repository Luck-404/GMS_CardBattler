//
//
// SCRIPT: SCR_GET_BEAST_INFO | BASED ON THE PASSED BEAST NAME, RETRIEVE A DSMAP WITH BASE BEAST INFORMATION | RETURNS DSLIST OF CARD MAPS
//
//
function scr_get_enemy_deck(_beast_name,_beast_type){
	var _return_deck = ds_list_create();
	//
	// SWITCH BASED ON BEAST NAME
	//
	switch (_beast_name){
	
		#region CERULEAN

		#endregion

		#region VERMILION

		#endregion

		#region VIRIDIAN
			#region ARBRAWN - MARTIAL-ADVENTURER
			case "ARBRAWN":
				switch(_beast_type){
					case "BOTANICAL":
						
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("EMERALD_SLAM"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("RAPID_STRIKES"));
						return _return_deck;
					break;
					
					case "NATURAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("EMERALD_SLAM"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						return _return_deck;
					break;
					
					case "WILD":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("BULWARK"));
						return _return_deck;
					break;
				}
			break;
			#endregion
			
			#region ARGENTBUD - TECHNICAL-MERCHANT
			case "ARGENTBUD":
				switch(_beast_type){
					case "BOTANICAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("RAPID_STRIKES"));
						return _return_deck;
					break;
					
					case "NATURAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						return _return_deck;
					break;
					
					case "WILD":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("DISEASE"));
						ds_list_add(_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("BULWARK"));
						return _return_deck;
					break;
				}
			break;
			#endregion
			
			#region BEAVINE - MARTIAL-ADVENTURER
			case "BEAVINE":
				switch(_beast_type){
					case "BOTANICAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("RAPID_STRIKES"));
						return _return_deck;
					break;
					
					case "NATURAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("DEFT_STRIKE"));
						return _return_deck;
					break;
					
					case "WILD":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("DISEASE"));
						ds_list_add(_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("BULWARK"));
						return _return_deck;
					break;
				}
			break;
			#endregion
			
			#region BRYOBITE
			
			#endregion
			
			#region CHITROOPER
			
			#endregion
			
			#region CRUSABER
			
			#endregion
			
			#region DRYADAE
			
			#endregion
			
			#region FIGHTREE
			
			#endregion
			
			#region FLITSAGE - MAGICAL-MAGE
			case "FLITSAGE":
				switch(_beast_type){
					case "BOTANICAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("RAPID_STRIKES"));
						return _return_deck;
					break;
					
					case "NATURAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("DEFT_STRIKE"));
						return _return_deck;
					break;
					
					case "WILD":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("DISEASE"));
						ds_list_add(_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("DEFT_STRIKE"));
						return _return_deck;
					break;
				}
			break;
			#endregion
			
			#region FURN - TECHNICAL-HUNTER
			case "FURN":
				switch(_beast_type){
					case "BOTANICAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("DEFT_STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("RAPID_STRIKES"));
						return _return_deck;
					break;
					
					case "NATURAL":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("DEFT_STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("DEFT_STRIKE"));
						return _return_deck;
					break;
					
					case "WILD":
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_return_deck,scr_get_card_info("DEFT_STRIKE"));
						return _return_deck;
					break;
				}
			break;
			#endregion			
		#endregion

	}
}