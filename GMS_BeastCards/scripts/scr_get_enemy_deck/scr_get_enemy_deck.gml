//===============================================================================//
//
// SCRIPT: SCR_GET_ENEMY_DECK
// FUNCTION: Returns an enemy deck for the given beast name and beast subtype.
//           Builds a ds_list containing fresh card structs.
//           Used when initializing enemy combat decks.
//
//===============================================================================//

function scr_get_enemy_deck(_str_beast_name,_str_beast_type){

	var _list_return_deck = ds_list_create();

	switch (_str_beast_name){

		#region CERULEAN

		#endregion

		#region VERMILION

		#endregion

		#region VIRIDIAN
			#region ARBRAWN - MARTIAL-ADVENTURER
			case "ARBRAWN":
				switch(_str_beast_type){
					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("EMERALD_SLAM"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("RAPID_STRIKES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("EMERALD_SLAM"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("BULWARK"));
					break;
				}
			break;
			#endregion

			#region ARGENTBUD - TECHNICAL-MERCHANT
			case "ARGENTBUD":
				switch(_str_beast_type){
					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("RAPID_STRIKES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("DISEASE"));
						ds_list_add(_list_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("BULWARK"));
					break;
				}
			break;
			#endregion

			#region BEAVINE - MARTIAL-ADVENTURER
			case "BEAVINE":
				switch(_str_beast_type){
					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("RAPID_STRIKES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("DEFT_STRIKE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("DISEASE"));
						ds_list_add(_list_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("BULWARK"));
					break;
				}
			break;
			#endregion

			#region FLITSAGE - MAGICAL-MAGE
			case "FLITSAGE":
				switch(_str_beast_type){
					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("RAPID_STRIKES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("DEFT_STRIKE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("DISEASE"));
						ds_list_add(_list_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("DEFT_STRIKE"));
					break;
				}
			break;
			#endregion

			#region FURN - TECHNICAL-HUNTER
			case "FURN":
				switch(_str_beast_type){
					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("DEFT_STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("RAPID_STRIKES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("DEFT_STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("DEFT_STRIKE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("MIRACLE_MUSA"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOCK"));
						ds_list_add(_list_return_deck,scr_get_card_info("DEFT_STRIKE"));
					break;
				}
			break;
			#endregion
		#endregion
	}

	return _list_return_deck;
}