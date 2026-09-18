//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_DECK
// FUNCTION: Builds and returns the card deck assigned to a Beast.
//           Adds shared cards for the Beast and subtype-specific cards based
//           on its active subtype.
//
// ARGUMENTS: _str_beast_name identifies the Beast and _str_beast_type identifies
//            its active subtype.
// RETURNS: A newly created DS list containing the Beast's assigned card structs.
//
//===============================================================================//

function scr_beast_get_deck(_str_beast_name,_str_beast_type){

	var _list_return_deck = ds_list_create();

	switch (_str_beast_name){

		#region CERULEAN

			#region AMMOMARSH
			case "AMMOMARSH":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("BITTER_CHILL"));
				ds_list_add(_list_return_deck,scr_card_get_info("COLD_SNAP"));
				ds_list_add(_list_return_deck,scr_card_get_info("DEPTH_CHARGE"));
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_ACCRETION"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("SHELL_SHIELD"));
						ds_list_add(_list_return_deck,scr_card_get_info("CORAL_GUARDIAN"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_BULWARK"));
						ds_list_add(_list_return_deck,scr_card_get_info("COOLING_MIST"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("SOOTHING_CURRENT"));
						ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_RECOVERY"));
					break;
				}

			break;
			#endregion


			#region BLIZZDRIFT
			case "BLIZZDRIFT":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("ABSOLUTE_ZERO"));
				ds_list_add(_list_return_deck,scr_card_get_info("WINTER_RESONANCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("GLACIAL_ERUPTION"));
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_PRISON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("DEPTH_CHARGE"));
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_CURSE"));
						ds_list_add(_list_return_deck,scr_card_get_info("HYPOTHERMIA"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("DEPTH_CHARGE"));
						ds_list_add(_list_return_deck,scr_card_get_info("STORM_BEACON"));
					break;
				}

			break;
			#endregion


			#region CAUDAQUA
			case "CAUDAQUA":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_LANCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
				ds_list_add(_list_return_deck,scr_card_get_info("TORRENT"));
				ds_list_add(_list_return_deck,scr_card_get_info("BRITTLE_CONSTITUTION"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
						ds_list_add(_list_return_deck,scr_card_get_info("DEEPFLOW_WHISPERSONG"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("RIMEFROST_ELEMENTAL"));
						ds_list_add(_list_return_deck,scr_card_get_info("THIN_ICE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("RIP_CURRENT"));
						ds_list_add(_list_return_deck,scr_card_get_info("UNDERTOW"));
					break;
				}

			break;
			#endregion


			#region CEPHARIME
			case "CEPHARIME":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("ARCTIC_VOLLEY"));
				ds_list_add(_list_return_deck,scr_card_get_info("SHATTER_STRIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("AQUA_STEP"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("WHIRLPOOL"));
						ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_SHELL"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("ICEBOUND_INSTINCT"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_ARMOR"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("PURIFY_WATERS"));
						ds_list_add(_list_return_deck,scr_card_get_info("COLD_RESERVE"));
					break;
				}

			break;
			#endregion


			#region CHELONSEA
			case "CHELONSEA":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
				ds_list_add(_list_return_deck,scr_card_get_info("CRASHING_WAVE"));
				ds_list_add(_list_return_deck,scr_card_get_info("BURST"));
				ds_list_add(_list_return_deck,scr_card_get_info("ANCHOR_STONE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_HARPOON"));
						ds_list_add(_list_return_deck,scr_card_get_info("CORAL_GUARDIAN"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_WALL"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_PLATING"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_HARPOON"));
						ds_list_add(_list_return_deck,scr_card_get_info("STORM_WISP"));
					break;
				}

			break;
			#endregion


			#region CORALLIARC
			case "CORALLIARC":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_LANCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
				ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_HARPOON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("DEEPFLOW_WHISPERSONG"));
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("BRITTLE_CONSTITUTION"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICEBOUND_SEAL"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("ANCHOR_STONE"));
						ds_list_add(_list_return_deck,scr_card_get_info("BUBBLE"));
					break;
				}

			break;
			#endregion


			#region FROSTUSK
			case "FROSTUSK":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_FANG"));
				ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_SLASH"));
				ds_list_add(_list_return_deck,scr_card_get_info("BURST"));
				ds_list_add(_list_return_deck,scr_card_get_info("CRYOGENIC_RECOVERY"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("SHELL_SHIELD"));
						ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_SHELL"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_ACCRETION"));
						ds_list_add(_list_return_deck,scr_card_get_info("ARCTIC_FOCUS"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("MARINE_MEND"));
						ds_list_add(_list_return_deck,scr_card_get_info("SAILORS_RESOLVE"));
					break;
				}

			break;
			#endregion


			#region GALENATRIUM
			case "GALENATRIUM":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("HAILSTONES"));
				ds_list_add(_list_return_deck,scr_card_get_info("DEPTH_CHARGE"));
				ds_list_add(_list_return_deck,scr_card_get_info("GLACIAL_ERUPTION"));
				ds_list_add(_list_return_deck,scr_card_get_info("RAIN"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_MIRROR"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("ABSOLUTE_ZERO"));
						ds_list_add(_list_return_deck,scr_card_get_info("WINTER_RESONANCE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("TORRENT"));
						ds_list_add(_list_return_deck,scr_card_get_info("STORM_BEACON"));
					break;
				}

			break;
			#endregion


			#region GLACIMIGHT
			case "GLACIMIGHT":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("ARCTIC_VOLLEY"));
				ds_list_add(_list_return_deck,scr_card_get_info("AVALANCHE_STRIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("WINTERS_BITE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SNOWFALL"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_FIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("GLACIAL_CRUSH"));
						ds_list_add(_list_return_deck,scr_card_get_info("SHATTER_STRIKE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_BREAK"));
						ds_list_add(_list_return_deck,scr_card_get_info("THUNDERSTORM"));
					break;
				}

			break;
			#endregion


			#region GULFLOW
			case "GULFLOW":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("FROSTBOLT"));
				ds_list_add(_list_return_deck,scr_card_get_info("BITTER_CHILL"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_SPEAR"));
				ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_RECOVERY"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("DEEPFLOW_WHISPERSONG"));
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_LANCE"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_PRECISION"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("RAIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("AQUA_STEP"));
					break;
				}

			break;
			#endregion


			#region ISTIRAIN
			case "ISTIRAIN":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
				ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_FIN"));
				ds_list_add(_list_return_deck,scr_card_get_info("CRASHING_WAVE"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_PRECISION"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
						ds_list_add(_list_return_deck,scr_card_get_info("WHIRLPOOL"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("PERMAFROST"));
						ds_list_add(_list_return_deck,scr_card_get_info("WHITEOUT"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_SLASH"));
						ds_list_add(_list_return_deck,scr_card_get_info("RIP_CURRENT"));
					break;
				}

			break;
			#endregion


			#region KELPLATANI
			case "KELPLATANI":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_SPEAR"));
				ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_FIN"));
				ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_SLASH"));
				ds_list_add(_list_return_deck,scr_card_get_info("MARINE_MEND"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("DEEPFLOW_WHISPERSONG"));
						ds_list_add(_list_return_deck,scr_card_get_info("ARMOR_TRANSFER"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_BASTION"));
						ds_list_add(_list_return_deck,scr_card_get_info("CHILLING_WEAKNESS"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("UNDERTOW"));
						ds_list_add(_list_return_deck,scr_card_get_info("WHIRLPOOL"));
					break;
				}

			break;
			#endregion


			#region LONTRIVER
			case "LONTRIVER":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("HAILSTONES"));
				ds_list_add(_list_return_deck,scr_card_get_info("WINTER_RESONANCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("COLD_SNAP"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROST_WEAPON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
						ds_list_add(_list_return_deck,scr_card_get_info("DEPTH_CHARGE"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("GLACIAL_ERUPTION"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROSTBOLT"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("DEPTH_CHARGE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SOOTHING_CURRENT"));
					break;
				}

			break;
			#endregion


			#region MARITIMICE
			case "MARITIMICE":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("AVALANCHE_STRIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("GLACIAL_CRUSH"));
				ds_list_add(_list_return_deck,scr_card_get_info("WINTERS_BITE"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_ARMOR"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_FIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("SHELL_SHIELD"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("ARCTIC_VOLLEY"));
						ds_list_add(_list_return_deck,scr_card_get_info("SNOWFORT"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("CRASHING_WAVE"));
						ds_list_add(_list_return_deck,scr_card_get_info("STATIC_BARRIER"));
					break;
				}

			break;
			#endregion


			#region SALTWAGG
			case "SALTWAGG":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_BREAK"));
				ds_list_add(_list_return_deck,scr_card_get_info("WHITEWATER"));
				ds_list_add(_list_return_deck,scr_card_get_info("GLACIAL_CRUSH"));
				ds_list_add(_list_return_deck,scr_card_get_info("THUNDERSTORM"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_FIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_SHELL"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("WINTERS_BITE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SNOWDRIFT"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("SEA_LEGS"));
						ds_list_add(_list_return_deck,scr_card_get_info("BUBBLE"));
					break;
				}

			break;
			#endregion


			#region SPHENISKIP
			case "SPHENISKIP":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_FANG"));
				ds_list_add(_list_return_deck,scr_card_get_info("TORRENT"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROSTBOLT"));
				ds_list_add(_list_return_deck,scr_card_get_info("STATIC_BARRIER"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SHARED_BULWARK"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("AVALANCHE_STRIKE"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_SPEAR"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("WHITEWATER"));
						ds_list_add(_list_return_deck,scr_card_get_info("SEA_LEGS"));
					break;
				}

			break;
			#endregion

		#endregion


		#region VERMILION

			#region ASCHEMASS
			case "ASCHEMASS":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region CANIGNIS
			case "CANIGNIS":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region DAIMONIS
			case "DAIMONIS":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region DRAKOAL
			case "DRAKOAL":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region EMBEROOST
			case "EMBEROOST":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region HELLSHROOM
			case "HELLSHROOM":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region IMPARCH
			case "IMPARCH":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region INFERNUS
			case "INFERNUS":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region LAVAROWANA
			case "LAVAROWANA":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region PYREKNIGHT
			case "PYREKNIGHT":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region PYROPLUME
			case "PYROPLUME":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region SANGUINAUT
			case "SANGUINAUT":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region SLAGOLEM
			case "SLAGOLEM":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region SOLEMOLD
			case "SOLEMOLD":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region WRATHOOD
			case "WRATHOOD":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

			#region WYRMELTA
			case "WYRMELTA":
				ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
			break;
			#endregion

		#endregion


		#region VIRIDIAN

			#region ARBRAWN
			case "ARBRAWN":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("SAVAGE_MAUL"));
				ds_list_add(_list_return_deck,scr_card_get_info("BEASTIAL_WRATH"));
				ds_list_add(_list_return_deck,scr_card_get_info("CLAW"));
				ds_list_add(_list_return_deck,scr_card_get_info("THICK_HIDE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("OLD_GROWTH_PUMMEL"));
						ds_list_add(_list_return_deck,scr_card_get_info("SINEWY_VINES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("SYMBIOSIS"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_BOND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("PHEROMONES"));
						ds_list_add(_list_return_deck,scr_card_get_info("STEELFUR"));
					break;
				}

			break;
			#endregion


			#region ARGENTBUD
			case "ARGENTBUD":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("BIOBOLT"));
				ds_list_add(_list_return_deck,scr_card_get_info("BLOWDART"));
				ds_list_add(_list_return_deck,scr_card_get_info("POTENT_SPORE"));
				ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SPRITE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SHIELD"));
						ds_list_add(_list_return_deck,scr_card_get_info("BURSTING_SEED"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURAL_RECOVERY"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("ROTTING_SPORES"));
						ds_list_add(_list_return_deck,scr_card_get_info("TOXIC_SNARE"));
					break;
				}

			break;
			#endregion


			#region BEAVINE
			case "BEAVINE":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("FELL"));
				ds_list_add(_list_return_deck,scr_card_get_info("SPINESLING"));
				ds_list_add(_list_return_deck,scr_card_get_info("VIRIDIAN_BURST"));
				ds_list_add(_list_return_deck,scr_card_get_info("GERMINATE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("OVERGROWTH"));
						ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("GREENSTEP"));
						ds_list_add(_list_return_deck,scr_card_get_info("LIFE_SPIRIT"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SAVAGE_MAUL"));
						ds_list_add(_list_return_deck,scr_card_get_info("WILD_VIGOR"));
					break;
				}

			break;
			#endregion


			#region BRYOBITE
			case "BRYOBITE":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("BLOWDART"));
				ds_list_add(_list_return_deck,scr_card_get_info("POTENT_SPORE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SPIT_VENOM"));
				ds_list_add(_list_return_deck,scr_card_get_info("NATURAL_RECOVERY"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("ROT_BLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("ROTTING_SPORES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("REGENERATE"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_BOND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("PREDATORS_MARK"));
						ds_list_add(_list_return_deck,scr_card_get_info("DISEASE"));
					break;
				}

			break;
			#endregion


			#region CHITROOPER
			case "CHITROOPER":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("FERAL_FRENZY"));
				ds_list_add(_list_return_deck,scr_card_get_info("RAKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SAVAGE_MAUL"));
				ds_list_add(_list_return_deck,scr_card_get_info("WILD_VIGOR"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("THORNMAIL"));
						ds_list_add(_list_return_deck,scr_card_get_info("BRAMBLE_HIDE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_GRACE"));
						ds_list_add(_list_return_deck,scr_card_get_info("CURE_ALL"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("STALKING_SWIPE"));
						ds_list_add(_list_return_deck,scr_card_get_info("TOXIC_HIDE"));
					break;
				}

			break;
			#endregion


			#region CRUSABER
			case "CRUSABER":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("STALKING_SWIPE"));
				ds_list_add(_list_return_deck,scr_card_get_info("NATURES_FURY"));
				ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_PIERCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("EMERALD_SLAM"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("ENTANGLE"));
						ds_list_add(_list_return_deck,scr_card_get_info("CRIPPLING_VINES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("SYMBIOSIS"));
						ds_list_add(_list_return_deck,scr_card_get_info("GREENSTEP"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("BEASTIAL_WRATH"));
						ds_list_add(_list_return_deck,scr_card_get_info("FERAL_FRENZY"));
					break;
				}

			break;
			#endregion


			#region DRYADAE
			case "DRYADAE":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("UNSEEN_ROOT"));
				ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_BOLT"));
				ds_list_add(_list_return_deck,scr_card_get_info("PRIMAL_BLAST"));
				ds_list_add(_list_return_deck,scr_card_get_info("SERPENT_SUMMON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("GROWTH_SIGIL"));
						ds_list_add(_list_return_deck,scr_card_get_info("CULTIVATE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_PIERCE"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_WRATH"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("ROT_BLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("BLOWDART"));
					break;
				}

			break;
			#endregion


			#region FIGHTREE
			case "FIGHTREE":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("FELL"));
				ds_list_add(_list_return_deck,scr_card_get_info("OLD_GROWTH_PUMMEL"));
				ds_list_add(_list_return_deck,scr_card_get_info("BEASTIAL_WRATH"));
				ds_list_add(_list_return_deck,scr_card_get_info("OVERGROWTH"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BARKSKIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("ROOTED_DEFENSE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("REGENERATE"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURAL_RECOVERY"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("THICK_HIDE"));
						ds_list_add(_list_return_deck,scr_card_get_info("INTERLOCKING_SCALES"));
					break;
				}

			break;
			#endregion


			#region FLITSAGE
			case "FLITSAGE":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("BRAMBLE_ERUPTION"));
				ds_list_add(_list_return_deck,scr_card_get_info("PRIMAL_BLAST"));
				ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_SWIPES"));
				ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_INSIGHT"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SPRITE"));
						ds_list_add(_list_return_deck,scr_card_get_info("POLLINATE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BIOBOLT"));
						ds_list_add(_list_return_deck,scr_card_get_info("SAPSPRING"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_BOLT"));
						ds_list_add(_list_return_deck,scr_card_get_info("WILDSTRIKE"));
					break;
				}

			break;
			#endregion


			#region FURN
			case "FURN":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("HUNTERS_JAVELIN"));
				ds_list_add(_list_return_deck,scr_card_get_info("HUNTERS_INSTINCT"));
				ds_list_add(_list_return_deck,scr_card_get_info("SNARLING_BITE"));
				ds_list_add(_list_return_deck,scr_card_get_info("PREDATORY_SCENT"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("THORN_NET"));
						ds_list_add(_list_return_deck,scr_card_get_info("POTENT_FRUIT"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_MEND"));
						ds_list_add(_list_return_deck,scr_card_get_info("CURE_ALL"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("RAKE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SPIKE_PIERCE"));
					break;
				}

			break;
			#endregion


			#region LEPOROOT
			case "LEPOROOT":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("SPIKE_PIERCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SPINESLING"));
				ds_list_add(_list_return_deck,scr_card_get_info("FERAL_FRENZY"));
				ds_list_add(_list_return_deck,scr_card_get_info("POTENT_FRUIT"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("UNSEEN_ROOT"));
						ds_list_add(_list_return_deck,scr_card_get_info("GERMINATE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("GREENSTEP"));
						ds_list_add(_list_return_deck,scr_card_get_info("REJUVENATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("THORN_NET"));
						ds_list_add(_list_return_deck,scr_card_get_info("SLEEP_DART"));
					break;
				}

			break;
			#endregion


			#region LUMBUCK
			case "LUMBUCK":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("BRAMBLE_ERUPTION"));
				ds_list_add(_list_return_deck,scr_card_get_info("NATURES_FURY"));
				ds_list_add(_list_return_deck,scr_card_get_info("WILDSTRIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("POLLINATE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("MIRACLE_MUSA"));
						ds_list_add(_list_return_deck,scr_card_get_info("SAPSPRING"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("LIFEBLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("SECOND_BLOOM"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("VIRIDIAN_BURST"));
						ds_list_add(_list_return_deck,scr_card_get_info("SPIT_VENOM"));
					break;
				}

			break;
			#endregion


			#region MAMBARK
			case "MAMBARK":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_FANG"));
				ds_list_add(_list_return_deck,scr_card_get_info("NATURES_WRATH"));
				ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_PIERCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("PREDATORS_MARK"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("VENOM_BLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("WILT"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_FURY"));
						ds_list_add(_list_return_deck,scr_card_get_info("BIOBOLT"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("PREDATORY_SCENT"));
						ds_list_add(_list_return_deck,scr_card_get_info("HUNTERS_INSTINCT"));
					break;
				}

			break;
			#endregion


			#region MORELUSH
			case "MORELUSH":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("GREENFLOW"));
				ds_list_add(_list_return_deck,scr_card_get_info("SPORE_CLOUD"));
				ds_list_add(_list_return_deck,scr_card_get_info("ROT_BLOOM"));
				ds_list_add(_list_return_deck,scr_card_get_info("CULTIVATE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("POTENT_SPORE"));
						ds_list_add(_list_return_deck,scr_card_get_info("BURGEONING_BLOOM"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("DRAINING_KISS"));
						ds_list_add(_list_return_deck,scr_card_get_info("REJUVENATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SERPENT_SUMMON"));
						ds_list_add(_list_return_deck,scr_card_get_info("POTENT_SPORE"));
					break;
				}

			break;
			#endregion


			#region SPOROSE
			case "SPOROSE":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("SPORE_CLOUD"));
				ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_BOLT"));
				ds_list_add(_list_return_deck,scr_card_get_info("NATURES_WRATH"));
				ds_list_add(_list_return_deck,scr_card_get_info("DECAYING_TOUCH"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BRAMBLE_ERUPTION"));
						ds_list_add(_list_return_deck,scr_card_get_info("SHIMMERING_SPORES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_FANG"));
						ds_list_add(_list_return_deck,scr_card_get_info("POLLINATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("PRIMAL_BLAST"));
						ds_list_add(_list_return_deck,scr_card_get_info("CLAW"));
					break;
				}

			break;
			#endregion


			#region STRIGIBLOOM
			case "STRIGIBLOOM":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("SPIKE_PIERCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("VIRIDIAN_BURST"));
				ds_list_add(_list_return_deck,scr_card_get_info("CLAW"));
				ds_list_add(_list_return_deck,scr_card_get_info("THORN_NET"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("SLEEPING_POLLEN"));
						ds_list_add(_list_return_deck,scr_card_get_info("BLOOMTIDE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_MEND"));
						ds_list_add(_list_return_deck,scr_card_get_info("CURE_ALL"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SNARLING_BITE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SPINESLING"));
					break;
				}

			break;
			#endregion


			#region TURFRANTULA
			case "TURFRANTULA":

				//========//
				//SHARED//
				//========//
				ds_list_add(_list_return_deck,scr_card_get_info("GREENFLOW"));
				ds_list_add(_list_return_deck,scr_card_get_info("SPIT_VENOM"));
				ds_list_add(_list_return_deck,scr_card_get_info("ROT_BLOOM"));
				ds_list_add(_list_return_deck,scr_card_get_info("GROWTH_SIGIL"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("SPORE_CLOUD"));
						ds_list_add(_list_return_deck,scr_card_get_info("LIFEBLOOM"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BURGEONING_BLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("LIFE_SPIRIT"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("VENOM_BLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("DECAYING_TOUCH"));
					break;
				}

			break;
			#endregion

		#endregion
	}

	//================//
	//FALLBACK DECK//
	//================//
	if (ds_list_size(_list_return_deck) <= 0){
		ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
	}

	return _list_return_deck;
}