function scr_get_enemy_deck(_str_beast_name,_str_beast_type){

	var _list_return_deck = ds_list_create();

	switch (_str_beast_name){

		#region CERULEAN
			#region AMMOMARSH
			case "AMMOMARSH":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region BLIZZDRIFT
			case "BLIZZDRIFT":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region CAUDAQUA
			case "CAUDAQUA":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region CEPHARIME
			case "CEPHARIME":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region CHELONSEA
			case "CHELONSEA":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region CORALLIARC
			case "CORALLIARC":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region FROSTUSK
			case "FROSTUSK":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region GALENATRIUM
			case "GALENATRIUM":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region GLACIMIGHT
			case "GLACIMIGHT":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region GULFLOW
			case "GULFLOW":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region ISTIRAIN
			case "ISTIRAIN":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region KELPLATANI
			case "KELPLATANI":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region LONTRIVER
			case "LONTRIVER":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region MARITIMICE
			case "MARITIMICE":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region SALTWAGG
			case "SALTWAGG":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region SPHENISKIP
			case "SPHENISKIP":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion
		#endregion

		#region VERMILION
			#region ASCHEMASS
			case "ASCHEMASS":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region CANIGNIS
			case "CANIGNIS":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region DAIMONIS
			case "DAIMONIS":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region DRAKOAL
			case "DRAKOAL":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region EMBEROOST
			case "EMBEROOST":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region HELLSHROOM
			case "HELLSHROOM":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region IMPARCH
			case "IMPARCH":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region INFERNUS
			case "INFERNUS":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region LAVAROWANA
			case "LAVAROWANA":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region PYREKNIGHT
			case "PYREKNIGHT":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region PYROPLUME
			case "PYROPLUME":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region SANGUINAUT
			case "SANGUINAUT":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region SLAGOLEM
			case "SLAGOLEM":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region SOLEMOLD
			case "SOLEMOLD":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region WRATHOOD
			case "WRATHOOD":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region WYRMELTA
			case "WYRMELTA":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion
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

			#region BRYOBITE
			case "BRYOBITE":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region CHITROOPER
			case "CHITROOPER":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region CRUSABER
			case "CRUSABER":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region DRYADAE
			case "DRYADAE":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region FIGHTREE
			case "FIGHTREE":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
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

			#region LEPOROOT
			case "LEPOROOT":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region LUMBUCK
			case "LUMBUCK":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region MAMBARK
			case "MAMBARK":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region MORELUSH
			case "MORELUSH":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region SPOROSE
			case "SPOROSE":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region STRIGIBLOOM
			case "STRIGIBLOOM":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion

			#region TURFRANTULA
			case "TURFRANTULA":
				ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
			break;
			#endregion
		#endregion
	}

	if (ds_list_size(_list_return_deck) <= 0){
		ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
	}

	return _list_return_deck;
}