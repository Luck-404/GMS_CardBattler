//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_DECK
// FUNCTION: Builds and returns the Card deck definition assigned to a Beast.
//           Adds shared Cards for the Beast and subtype-specific Cards based
//           on its active subtype.
//
// ARGUMENTS: _str_beast_name identifies the Beast and _str_beast_type identifies
//            its active subtype.
//
// RETURNS: Array containing the Beast's assigned Card structs.
//
//===============================================================================//

function scr_beast_get_deck(_str_beast_name,_str_beast_type){

	var _arr_return_deck = [];

	switch (_str_beast_name){

		#region CERULEAN

			#region AMMOMARSH
			case "AMMOMARSH":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("BITTER_CHILL"));
				array_push(_arr_return_deck,scr_card_get_info("COLD_SNAP"));
				array_push(_arr_return_deck,scr_card_get_info("DEPTH_CHARGE"));
				array_push(_arr_return_deck,scr_card_get_info("ICE_ACCRETION"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("SHELL_SHIELD"));
						array_push(_arr_return_deck,scr_card_get_info("CORAL_GUARDIAN"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("FROZEN_BULWARK"));
						array_push(_arr_return_deck,scr_card_get_info("COOLING_MIST"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("SOOTHING_CURRENT"));
						array_push(_arr_return_deck,scr_card_get_info("TIDAL_RECOVERY"));
					break;
				}

			break;
			#endregion


			#region BLIZZDRIFT
			case "BLIZZDRIFT":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("ABSOLUTE_ZERO"));
				array_push(_arr_return_deck,scr_card_get_info("WINTER_RESONANCE"));
				array_push(_arr_return_deck,scr_card_get_info("GLACIAL_ERUPTION"));
				array_push(_arr_return_deck,scr_card_get_info("ICE_PRISON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("DEPTH_CHARGE"));
						array_push(_arr_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("FROZEN_CURSE"));
						array_push(_arr_return_deck,scr_card_get_info("HYPOTHERMIA"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("DEPTH_CHARGE"));
						array_push(_arr_return_deck,scr_card_get_info("STORM_BEACON"));
					break;
				}

			break;
			#endregion


			#region CAUDAQUA
			case "CAUDAQUA":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("ICE_LANCE"));
				array_push(_arr_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
				array_push(_arr_return_deck,scr_card_get_info("TORRENT"));
				array_push(_arr_return_deck,scr_card_get_info("BRITTLE_CONSTITUTION"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
						array_push(_arr_return_deck,scr_card_get_info("DEEPFLOW_WHISPERSONG"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("RIMEFROST_ELEMENTAL"));
						array_push(_arr_return_deck,scr_card_get_info("THIN_ICE"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("RIP_CURRENT"));
						array_push(_arr_return_deck,scr_card_get_info("UNDERTOW"));
					break;
				}

			break;
			#endregion


			#region CEPHARIME
			case "CEPHARIME":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("ARCTIC_VOLLEY"));
				array_push(_arr_return_deck,scr_card_get_info("SHATTER_STRIKE"));
				array_push(_arr_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
				array_push(_arr_return_deck,scr_card_get_info("AQUA_STEP"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("WHIRLPOOL"));
						array_push(_arr_return_deck,scr_card_get_info("RAZOR_SHELL"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("ICEBOUND_INSTINCT"));
						array_push(_arr_return_deck,scr_card_get_info("FROZEN_ARMOR"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("PURIFY_WATERS"));
						array_push(_arr_return_deck,scr_card_get_info("COLD_RESERVE"));
					break;
				}

			break;
			#endregion


			#region CHELONSEA
			case "CHELONSEA":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
				array_push(_arr_return_deck,scr_card_get_info("CRASHING_WAVE"));
				array_push(_arr_return_deck,scr_card_get_info("BURST"));
				array_push(_arr_return_deck,scr_card_get_info("ANCHOR_STONE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("ABYSSAL_HARPOON"));
						array_push(_arr_return_deck,scr_card_get_info("CORAL_GUARDIAN"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("ICE_WALL"));
						array_push(_arr_return_deck,scr_card_get_info("ICE_PLATING"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("ABYSSAL_HARPOON"));
						array_push(_arr_return_deck,scr_card_get_info("STORM_WISP"));
					break;
				}

			break;
			#endregion


			#region CORALLIARC
			case "CORALLIARC":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("ICE_LANCE"));
				array_push(_arr_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
				array_push(_arr_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
				array_push(_arr_return_deck,scr_card_get_info("ABYSSAL_HARPOON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("DEEPFLOW_WHISPERSONG"));
						array_push(_arr_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("BRITTLE_CONSTITUTION"));
						array_push(_arr_return_deck,scr_card_get_info("ICEBOUND_SEAL"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("GATHERING_STORM"));
						array_push(_arr_return_deck,scr_card_get_info("BUBBLE"));
					break;
				}

			break;
			#endregion


			#region FROSTUSK
			case "FROSTUSK":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FROZEN_FANG"));
				array_push(_arr_return_deck,scr_card_get_info("TIDAL_SLASH"));
				array_push(_arr_return_deck,scr_card_get_info("BURST"));
				array_push(_arr_return_deck,scr_card_get_info("CRYOGENIC_RECOVERY"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("SHELL_SHIELD"));
						array_push(_arr_return_deck,scr_card_get_info("RAZOR_SHELL"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("ICE_ACCRETION"));
						array_push(_arr_return_deck,scr_card_get_info("ARCTIC_FOCUS"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("MARINE_MEND"));
						array_push(_arr_return_deck,scr_card_get_info("SAILORS_RESOLVE"));
					break;
				}

			break;
			#endregion


			#region GALENATRIUM
			case "GALENATRIUM":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("THUNDERCLAP"));
				array_push(_arr_return_deck,scr_card_get_info("DEPTH_CHARGE"));
				array_push(_arr_return_deck,scr_card_get_info("GLACIAL_ERUPTION"));
				array_push(_arr_return_deck,scr_card_get_info("RAIN"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
						array_push(_arr_return_deck,scr_card_get_info("ICE_MIRROR"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("ABSOLUTE_ZERO"));
						array_push(_arr_return_deck,scr_card_get_info("WINTER_RESONANCE"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("TORRENT"));
						array_push(_arr_return_deck,scr_card_get_info("STORM_BEACON"));
					break;
				}

			break;
			#endregion


			#region GLACIMIGHT
			case "GLACIMIGHT":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("ARCTIC_VOLLEY"));
				array_push(_arr_return_deck,scr_card_get_info("AVALANCHE_STRIKE"));
				array_push(_arr_return_deck,scr_card_get_info("WINTERS_BITE"));
				array_push(_arr_return_deck,scr_card_get_info("SNOWFALL"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("RAZOR_FIN"));
						array_push(_arr_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("GLACIAL_CRUSH"));
						array_push(_arr_return_deck,scr_card_get_info("SHATTER_STRIKE"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("TIDAL_BREAK"));
						array_push(_arr_return_deck,scr_card_get_info("THUNDERSTORM"));
					break;
				}

			break;
			#endregion


			#region GULFLOW
			case "GULFLOW":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FROSTBOLT"));
				array_push(_arr_return_deck,scr_card_get_info("BITTER_CHILL"));
				array_push(_arr_return_deck,scr_card_get_info("FROZEN_SPEAR"));
				array_push(_arr_return_deck,scr_card_get_info("TIDAL_RECOVERY"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("DEEPFLOW_WHISPERSONG"));
						array_push(_arr_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("ICE_LANCE"));
						array_push(_arr_return_deck,scr_card_get_info("FROZEN_PRECISION"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("RAIN"));
						array_push(_arr_return_deck,scr_card_get_info("AQUA_STEP"));
					break;
				}

			break;
			#endregion


			#region ISTIRAIN
			case "ISTIRAIN":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FORCED_OVERLOAD"));
				array_push(_arr_return_deck,scr_card_get_info("RAZOR_FIN"));
				array_push(_arr_return_deck,scr_card_get_info("CRASHING_WAVE"));
				array_push(_arr_return_deck,scr_card_get_info("FROZEN_PRECISION"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
						array_push(_arr_return_deck,scr_card_get_info("WHIRLPOOL"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("PERMAFROST"));
						array_push(_arr_return_deck,scr_card_get_info("WHITEOUT"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("TIDAL_SLASH"));
						array_push(_arr_return_deck,scr_card_get_info("RIP_CURRENT"));
					break;
				}

			break;
			#endregion


			#region KELPLATANI
			case "KELPLATANI":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FROZEN_SPEAR"));
				array_push(_arr_return_deck,scr_card_get_info("RAZOR_FIN"));
				array_push(_arr_return_deck,scr_card_get_info("TIDAL_SLASH"));
				array_push(_arr_return_deck,scr_card_get_info("MARINE_MEND"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("DEEPFLOW_WHISPERSONG"));
						array_push(_arr_return_deck,scr_card_get_info("ARMOR_TRANSFER"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("FROZEN_BASTION"));
						array_push(_arr_return_deck,scr_card_get_info("CHILLING_WEAKNESS"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("UNDERTOW"));
						array_push(_arr_return_deck,scr_card_get_info("STATIC_RESONANCE"));
					break;
				}

			break;
			#endregion


			#region LONTRIVER
			case "LONTRIVER":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("HAILSTONES"));
				array_push(_arr_return_deck,scr_card_get_info("WINTER_RESONANCE"));
				array_push(_arr_return_deck,scr_card_get_info("COLD_SNAP"));
				array_push(_arr_return_deck,scr_card_get_info("FROST_WEAPON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
						array_push(_arr_return_deck,scr_card_get_info("DEPTH_CHARGE"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("GLACIAL_ERUPTION"));
						array_push(_arr_return_deck,scr_card_get_info("FROSTBOLT"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("DEPTH_CHARGE"));
						array_push(_arr_return_deck,scr_card_get_info("SOOTHING_CURRENT"));
					break;
				}

			break;
			#endregion


			#region MARITIMICE
			case "MARITIMICE":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("AVALANCHE_STRIKE"));
				array_push(_arr_return_deck,scr_card_get_info("GLACIAL_CRUSH"));
				array_push(_arr_return_deck,scr_card_get_info("WINTERS_BITE"));
				array_push(_arr_return_deck,scr_card_get_info("FROZEN_ARMOR"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("RAZOR_FIN"));
						array_push(_arr_return_deck,scr_card_get_info("SHELL_SHIELD"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("ARCTIC_VOLLEY"));
						array_push(_arr_return_deck,scr_card_get_info("SNOWFORT"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("CRASHING_WAVE"));
						array_push(_arr_return_deck,scr_card_get_info("STATIC_BARRIER"));
					break;
				}

			break;
			#endregion


			#region SALTWAGG
			case "SALTWAGG":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("TIDAL_BREAK"));
				array_push(_arr_return_deck,scr_card_get_info("WHITEWATER"));
				array_push(_arr_return_deck,scr_card_get_info("GLACIAL_CRUSH"));
				array_push(_arr_return_deck,scr_card_get_info("THUNDERSTORM"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("RAZOR_FIN"));
						array_push(_arr_return_deck,scr_card_get_info("RAZOR_SHELL"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("WINTERS_BITE"));
						array_push(_arr_return_deck,scr_card_get_info("SNOWDRIFT"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("SEA_LEGS"));
						array_push(_arr_return_deck,scr_card_get_info("BUBBLE"));
					break;
				}

			break;
			#endregion


			#region SPHENISKIP
			case "SPHENISKIP":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FROZEN_FANG"));
				array_push(_arr_return_deck,scr_card_get_info("TORRENT"));
				array_push(_arr_return_deck,scr_card_get_info("FROSTBOLT"));
				array_push(_arr_return_deck,scr_card_get_info("STATIC_BARRIER"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ABYSS":
						array_push(_arr_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
						array_push(_arr_return_deck,scr_card_get_info("SHARED_BULWARK"));
					break;

					case "FROST":
						array_push(_arr_return_deck,scr_card_get_info("AVALANCHE_STRIKE"));
						array_push(_arr_return_deck,scr_card_get_info("FROZEN_SPEAR"));
					break;

					case "WAVE":
						array_push(_arr_return_deck,scr_card_get_info("WHITEWATER"));
						array_push(_arr_return_deck,scr_card_get_info("SEA_LEGS"));
					break;
				}

			break;
			#endregion

		#endregion


		#region VERMILION

			#region ASCHEMASS
			case "ASCHEMASS":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("COMBUSTION"));
				array_push(_arr_return_deck,scr_card_get_info("BLOOD_FURNACE"));
				array_push(_arr_return_deck,scr_card_get_info("BLOODFLAME_BOLT"));
				array_push(_arr_return_deck,scr_card_get_info("FIRESTORM"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOOD_OATH"));
						array_push(_arr_return_deck,scr_card_get_info("HARDEN_BLOOD"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("CINDERGUARD"));
						array_push(_arr_return_deck,scr_card_get_info("MOLTEN_BRAND"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("HEATWAVE"));
						array_push(_arr_return_deck,scr_card_get_info("3RD_DEGREE"));
					break;

				}

			break;
			#endregion


			#region CANIGNIS
			case "CANIGNIS":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("CINDER_SPEAR"));
				array_push(_arr_return_deck,scr_card_get_info("BARBED_BOLT"));
				array_push(_arr_return_deck,scr_card_get_info("MOLTEN_EDGE"));
				array_push(_arr_return_deck,scr_card_get_info("BLOODHUNGER"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOODY_SWIPE"));
						array_push(_arr_return_deck,scr_card_get_info("BLOODSTEP"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("POWDER_KEG"));
						array_push(_arr_return_deck,scr_card_get_info("ERUPTING_SLAM"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("SCORCHING_CLAW"));
						array_push(_arr_return_deck,scr_card_get_info("VOLATILE_BRAND"));
					break;

				}

			break;
			#endregion


			#region DAIMONIS
			case "DAIMONIS":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FEED_THE_FLAME"));
				array_push(_arr_return_deck,scr_card_get_info("PYROCLAST"));
				array_push(_arr_return_deck,scr_card_get_info("EMBER_SHOT"));
				array_push(_arr_return_deck,scr_card_get_info("FLAMESPAWN"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOODMIST"));
						array_push(_arr_return_deck,scr_card_get_info("BLOODFLAME_BOLT"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("BLOOD_FURNACE"));
						array_push(_arr_return_deck,scr_card_get_info("EMBER_TURRET"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("FIRESTORM"));
						array_push(_arr_return_deck,scr_card_get_info("3RD_DEGREE"));
					break;

				}

			break;
			#endregion


			#region DRAKOAL
			case "DRAKOAL":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("SEARING_RAY"));
				array_push(_arr_return_deck,scr_card_get_info("BURNING_MISSILES"));
				array_push(_arr_return_deck,scr_card_get_info("OVERHEAT"));
				array_push(_arr_return_deck,scr_card_get_info("MOLTEN_AEGIS"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("ANEMIA"));
						array_push(_arr_return_deck,scr_card_get_info("CRIMSON_FOCUS"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("BACKDRAFT"));
						array_push(_arr_return_deck,scr_card_get_info("LIVING_FLAME"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("BLOODFLAME_BOLT"));
						array_push(_arr_return_deck,scr_card_get_info("DANCING_FLAME"));
					break;

				}

			break;
			#endregion


			#region EMBEROOST
			case "EMBEROOST":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("RAGEHOOK"));
				array_push(_arr_return_deck,scr_card_get_info("RECKLESS_ASSAULT"));
				array_push(_arr_return_deck,scr_card_get_info("FLAME_LANCE"));
				array_push(_arr_return_deck,scr_card_get_info("LAST_STAND"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOODY_SHIELD"));
						array_push(_arr_return_deck,scr_card_get_info("BLOODCOATED"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("RAGEPLATE"));
						array_push(_arr_return_deck,scr_card_get_info("BURNING_MISSILES"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("HEAT_UP"));
						array_push(_arr_return_deck,scr_card_get_info("FLAMING_LASHES"));
					break;

				}

			break;
			#endregion


			#region HELLSHROOM
			case "HELLSHROOM":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FLAME_SPOUT"));
				array_push(_arr_return_deck,scr_card_get_info("EMBER_BARRAGE"));
				array_push(_arr_return_deck,scr_card_get_info("BLOODFLAME_NEEDLE"));
				array_push(_arr_return_deck,scr_card_get_info("EMBER_TURRET"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("HEMOPHILIA"));
						array_push(_arr_return_deck,scr_card_get_info("ARTERIAL_BURST"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("FLAMESPAWN"));
						array_push(_arr_return_deck,scr_card_get_info("FEED_THE_FLAME"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("HEATWAVE"));
						array_push(_arr_return_deck,scr_card_get_info("HUNGERING_FLAMES"));
					break;

				}

			break;
			#endregion


			#region IMPARCH
			case "IMPARCH":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("MELTPLATE"));
				array_push(_arr_return_deck,scr_card_get_info("CINDER_KICK"));
				array_push(_arr_return_deck,scr_card_get_info("RAGING_SPARK"));
				array_push(_arr_return_deck,scr_card_get_info("HEAT_UP"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOODSTEP"));
						array_push(_arr_return_deck,scr_card_get_info("ANEMIA"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("MAGMA_CANNON"));
						array_push(_arr_return_deck,scr_card_get_info("FURNACE_HEART"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("EMBER_TURRET"));
						array_push(_arr_return_deck,scr_card_get_info("DANCING_FLAME"));
					break;

				}

			break;
			#endregion


			#region INFERNUS
			case "INFERNUS":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FORWARD_MARCH"));
				array_push(_arr_return_deck,scr_card_get_info("BREAKJAW"));
				array_push(_arr_return_deck,scr_card_get_info("RECKLESS_ASSAULT"));
				array_push(_arr_return_deck,scr_card_get_info("BATTLE_FRENZY"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BATTLE_TRANCE"));
						array_push(_arr_return_deck,scr_card_get_info("MENACING_ROAR"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("CINDERGUARD"));
						array_push(_arr_return_deck,scr_card_get_info("BURNING_MISSILES"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("EMBER_SHOT"));
						array_push(_arr_return_deck,scr_card_get_info("HEAT_UP"));
					break;

				}

			break;
			#endregion


			#region LAVAROWANA
			case "LAVAROWANA":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FIERY_BLOW"));
				array_push(_arr_return_deck,scr_card_get_info("RENDING_BLOW"));
				array_push(_arr_return_deck,scr_card_get_info("BLOOD_PRICE"));
				array_push(_arr_return_deck,scr_card_get_info("SECOND_WIND"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BARBED_BOLT"));
						array_push(_arr_return_deck,scr_card_get_info("BLOOD_OATH"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("FLAMESPAWN"));
						array_push(_arr_return_deck,scr_card_get_info("ERUPTING_SLAM"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("SCORCHING_CLAW"));
						array_push(_arr_return_deck,scr_card_get_info("HEATWAVE"));
					break;

				}

			break;
			#endregion


			#region PYREKNIGHT
			case "PYREKNIGHT":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("RAGING_BLOW"));
				array_push(_arr_return_deck,scr_card_get_info("BURNING_CLEAVE"));
				array_push(_arr_return_deck,scr_card_get_info("BLOODLUST_LUNGE"));
				array_push(_arr_return_deck,scr_card_get_info("PAIN_RESPONSE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("FRONTLINE_ORDER"));
						array_push(_arr_return_deck,scr_card_get_info("BATTLE_TRANCE"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("CINDERGUARD"));
						array_push(_arr_return_deck,scr_card_get_info("RAGEHOOK"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("BURNING_PARRY"));
						array_push(_arr_return_deck,scr_card_get_info("SCORCHING_CLAW"));
					break;

				}

			break;
			#endregion


			#region PYROPLUME
			case "PYROPLUME":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FLASHPOINT"));
				array_push(_arr_return_deck,scr_card_get_info("HELLFIRE_STRIKE"));
				array_push(_arr_return_deck,scr_card_get_info("COMBUSTION"));
				array_push(_arr_return_deck,scr_card_get_info("PYRE_WEAPON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOODFLAME_NEEDLE"));
						array_push(_arr_return_deck,scr_card_get_info("ARTERIAL_BURST"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("PYROCLAST"));
						array_push(_arr_return_deck,scr_card_get_info("BLOOD_FURNACE"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("INNER_FLAME"));
						array_push(_arr_return_deck,scr_card_get_info("3RD_DEGREE"));
					break;

				}

			break;
			#endregion


			#region SANGUINAUT
			case "SANGUINAUT":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("OPEN_VEIN"));
				array_push(_arr_return_deck,scr_card_get_info("RAGEHOOK"));
				array_push(_arr_return_deck,scr_card_get_info("RECKLESS_ASSAULT"));
				array_push(_arr_return_deck,scr_card_get_info("BLOODCOATED"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOODHUNGER"));
						array_push(_arr_return_deck,scr_card_get_info("ARTERIAL_BURST"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("BURNING_CLEAVE"));
						array_push(_arr_return_deck,scr_card_get_info("MOLTEN_AEGIS"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("BLOODFLAME_NEEDLE"));
						array_push(_arr_return_deck,scr_card_get_info("FLAME_LANCE"));
					break;

				}

			break;
			#endregion


			#region SLAGOLEM
			case "SLAGOLEM":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("BERSERKER_FLURRY"));
				array_push(_arr_return_deck,scr_card_get_info("FURIOUS_SLICE"));
				array_push(_arr_return_deck,scr_card_get_info("BERSERKER_CHARGE"));
				array_push(_arr_return_deck,scr_card_get_info("FRONTLINE_ORDER"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("HARDEN_BLOOD"));
						array_push(_arr_return_deck,scr_card_get_info("BLOOD_OATH"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("CINDERGUARD"));
						array_push(_arr_return_deck,scr_card_get_info("RAGEPLATE"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("BURNING_PARRY"));
						array_push(_arr_return_deck,scr_card_get_info("MOLTEN_AEGIS"));
					break;

				}

			break;
			#endregion


			#region SOLEMOLD
			case "SOLEMOLD":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("ERUPTING_SLAM"));
				array_push(_arr_return_deck,scr_card_get_info("SCORCHING_CLAW"));
				array_push(_arr_return_deck,scr_card_get_info("MOLTEN_EDGE"));
				array_push(_arr_return_deck,scr_card_get_info("DRAGON_MINE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOODY_SHIELD"));
						array_push(_arr_return_deck,scr_card_get_info("BLOODSTEP"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("FLAMEFORGED"));
						array_push(_arr_return_deck,scr_card_get_info("MELTING_ARMAMENTS"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("VOLATILE_BRAND"));
						array_push(_arr_return_deck,scr_card_get_info("CINDER_SPEAR"));
					break;

				}

			break;
			#endregion


			#region WRATHOOD
			case "WRATHOOD":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("ARTERIAL_BURST"));
				array_push(_arr_return_deck,scr_card_get_info("BLOODY_SWIPE"));
				array_push(_arr_return_deck,scr_card_get_info("FINISHING_BLOW"));
				array_push(_arr_return_deck,scr_card_get_info("HEMOPHILIA"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("ANEMIA"));
						array_push(_arr_return_deck,scr_card_get_info("RENDING_BLOW"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("CINDER_KICK"));
						array_push(_arr_return_deck,scr_card_get_info("MOLTEN_BRAND"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("CAUTERIZED_WOUND"));
						array_push(_arr_return_deck,scr_card_get_info("DANCING_FLAME"));
					break;

				}

			break;
			#endregion


			#region WYRMELTA
			case "WYRMELTA":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("SEARING_RAY"));
				array_push(_arr_return_deck,scr_card_get_info("EMBER_BARRAGE"));
				array_push(_arr_return_deck,scr_card_get_info("OVERHEAT"));
				array_push(_arr_return_deck,scr_card_get_info("CRIMSON_FOCUS"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "ASH":
						array_push(_arr_return_deck,scr_card_get_info("BLOODFLAME_BOLT"));
						array_push(_arr_return_deck,scr_card_get_info("BLOODHUNGER"));
					break;

					case "MAGMA":
						array_push(_arr_return_deck,scr_card_get_info("MELTPLATE"));
						array_push(_arr_return_deck,scr_card_get_info("LIVING_FLAME"));
					break;

					case "PYRE":
						array_push(_arr_return_deck,scr_card_get_info("BURNING_MISSILES"));
						array_push(_arr_return_deck,scr_card_get_info("HEAT_UP"));
					break;

				}

			break;
			#endregion


		#endregion


		#region VIRIDIAN

			#region ARBRAWN
			case "ARBRAWN":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("SAVAGE_MAUL"));
				array_push(_arr_return_deck,scr_card_get_info("BEASTIAL_WRATH"));
				array_push(_arr_return_deck,scr_card_get_info("CLAW"));
				array_push(_arr_return_deck,scr_card_get_info("THICK_HIDE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("OLD_GROWTH_PUMMEL"));
						array_push(_arr_return_deck,scr_card_get_info("SINEWY_VINES"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("SYMBIOSIS"));
						array_push(_arr_return_deck,scr_card_get_info("NATURES_BOND"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("PHEROMONES"));
						array_push(_arr_return_deck,scr_card_get_info("STEELFUR"));
					break;
				}

			break;
			#endregion


			#region ARGENTBUD
			case "ARGENTBUD":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("BIOBOLT"));
				array_push(_arr_return_deck,scr_card_get_info("BLOWDART"));
				array_push(_arr_return_deck,scr_card_get_info("POTENT_SPORE"));
				array_push(_arr_return_deck,scr_card_get_info("BLOOMING_SPRITE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("BLOOMING_SHIELD"));
						array_push(_arr_return_deck,scr_card_get_info("BURSTING_SEED"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("LIFE_SPIRIT"));
						array_push(_arr_return_deck,scr_card_get_info("NATURAL_RECOVERY"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("ROTTING_SPORES"));
						array_push(_arr_return_deck,scr_card_get_info("TOXIC_SNARE"));
					break;
				}

			break;
			#endregion


			#region BEAVINE
			case "BEAVINE":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FELL"));
				array_push(_arr_return_deck,scr_card_get_info("SPINESLING"));
				array_push(_arr_return_deck,scr_card_get_info("VIRIDIAN_BURST"));
				array_push(_arr_return_deck,scr_card_get_info("GERMINATE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("OVERGROWTH"));
						array_push(_arr_return_deck,scr_card_get_info("DORMANT_SEED"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("GREENSTEP"));
						array_push(_arr_return_deck,scr_card_get_info("LIFE_SPIRIT"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("SAVAGE_MAUL"));
						array_push(_arr_return_deck,scr_card_get_info("WILD_VIGOR"));
					break;
				}

			break;
			#endregion


			#region BRYOBITE
			case "BRYOBITE":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("BLOWDART"));
				array_push(_arr_return_deck,scr_card_get_info("POTENT_SPORE"));
				array_push(_arr_return_deck,scr_card_get_info("SPIT_VENOM"));
				array_push(_arr_return_deck,scr_card_get_info("NATURAL_RECOVERY"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("ROT_BLOOM"));
						array_push(_arr_return_deck,scr_card_get_info("ROTTING_SPORES"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("REGENERATE"));
						array_push(_arr_return_deck,scr_card_get_info("NATURES_BOND"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("PREDATORS_MARK"));
						array_push(_arr_return_deck,scr_card_get_info("DISEASE"));
					break;
				}

			break;
			#endregion


			#region CHITROOPER
			case "CHITROOPER":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FERAL_FRENZY"));
				array_push(_arr_return_deck,scr_card_get_info("RAKE"));
				array_push(_arr_return_deck,scr_card_get_info("SAVAGE_MAUL"));
				array_push(_arr_return_deck,scr_card_get_info("WILD_VIGOR"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("THORNMAIL"));
						array_push(_arr_return_deck,scr_card_get_info("BRAMBLE_HIDE"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("NATURES_GRACE"));
						array_push(_arr_return_deck,scr_card_get_info("CURE_ALL"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("STALKING_SWIPE"));
						array_push(_arr_return_deck,scr_card_get_info("TOXIC_HIDE"));
					break;
				}

			break;
			#endregion


			#region CRUSABER
			case "CRUSABER":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("STALKING_SWIPE"));
				array_push(_arr_return_deck,scr_card_get_info("NATURES_FURY"));
				array_push(_arr_return_deck,scr_card_get_info("SPIRIT_PIERCE"));
				array_push(_arr_return_deck,scr_card_get_info("EMERALD_SLAM"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("ENTANGLE"));
						array_push(_arr_return_deck,scr_card_get_info("CRIPPLING_VINES"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("SYMBIOSIS"));
						array_push(_arr_return_deck,scr_card_get_info("GREENSTEP"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("BEASTIAL_WRATH"));
						array_push(_arr_return_deck,scr_card_get_info("FERAL_FRENZY"));
					break;
				}

			break;
			#endregion


			#region DRYADAE
			case "DRYADAE":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("UNSEEN_ROOT"));
				array_push(_arr_return_deck,scr_card_get_info("VERDANT_BOLT"));
				array_push(_arr_return_deck,scr_card_get_info("PRIMAL_BLAST"));
				array_push(_arr_return_deck,scr_card_get_info("SERPENT_SUMMON"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("GROWTH_SIGIL"));
						array_push(_arr_return_deck,scr_card_get_info("CULTIVATE"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("SPIRIT_PIERCE"));
						array_push(_arr_return_deck,scr_card_get_info("NATURES_WRATH"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("ROT_BLOOM"));
						array_push(_arr_return_deck,scr_card_get_info("BLOWDART"));
					break;
				}

			break;
			#endregion


			#region FIGHTREE
			case "FIGHTREE":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("FELL"));
				array_push(_arr_return_deck,scr_card_get_info("OLD_GROWTH_PUMMEL"));
				array_push(_arr_return_deck,scr_card_get_info("BEASTIAL_WRATH"));
				array_push(_arr_return_deck,scr_card_get_info("OVERGROWTH"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("BARKSKIN"));
						array_push(_arr_return_deck,scr_card_get_info("ROOTED_DEFENSE"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("REGENERATE"));
						array_push(_arr_return_deck,scr_card_get_info("NATURAL_RECOVERY"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("THICK_HIDE"));
						array_push(_arr_return_deck,scr_card_get_info("INTERLOCKING_SCALES"));
					break;
				}

			break;
			#endregion


			#region FLITSAGE
			case "FLITSAGE":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("BRAMBLE_ERUPTION"));
				array_push(_arr_return_deck,scr_card_get_info("PRIMAL_BLAST"));
				array_push(_arr_return_deck,scr_card_get_info("VERDANT_SWIPES"));
				array_push(_arr_return_deck,scr_card_get_info("VERDANT_INSIGHT"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("BLOOMING_SPRITE"));
						array_push(_arr_return_deck,scr_card_get_info("POLLINATE"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("BIOBOLT"));
						array_push(_arr_return_deck,scr_card_get_info("SAPSPRING"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("VERDANT_BOLT"));
						array_push(_arr_return_deck,scr_card_get_info("WILDSTRIKE"));
					break;
				}

			break;
			#endregion


			#region FURN
			case "FURN":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("HUNTERS_JAVELIN"));
				array_push(_arr_return_deck,scr_card_get_info("HUNTERS_INSTINCT"));
				array_push(_arr_return_deck,scr_card_get_info("SNARLING_BITE"));
				array_push(_arr_return_deck,scr_card_get_info("PREDATORY_SCENT"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("THORN_NET"));
						array_push(_arr_return_deck,scr_card_get_info("POTENT_FRUIT"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("NATURES_MEND"));
						array_push(_arr_return_deck,scr_card_get_info("CURE_ALL"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("RAKE"));
						array_push(_arr_return_deck,scr_card_get_info("SPIKE_PIERCE"));
					break;
				}

			break;
			#endregion


			#region LEPOROOT
			case "LEPOROOT":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("SPIKE_PIERCE"));
				array_push(_arr_return_deck,scr_card_get_info("SPINESLING"));
				array_push(_arr_return_deck,scr_card_get_info("FERAL_FRENZY"));
				array_push(_arr_return_deck,scr_card_get_info("POTENT_FRUIT"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("UNSEEN_ROOT"));
						array_push(_arr_return_deck,scr_card_get_info("GERMINATE"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("GREENSTEP"));
						array_push(_arr_return_deck,scr_card_get_info("REJUVENATE"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("THORN_NET"));
						array_push(_arr_return_deck,scr_card_get_info("SLEEP_DART"));
					break;
				}

			break;
			#endregion


			#region LUMBUCK
			case "LUMBUCK":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("BRAMBLE_ERUPTION"));
				array_push(_arr_return_deck,scr_card_get_info("NATURES_FURY"));
				array_push(_arr_return_deck,scr_card_get_info("WILDSTRIKE"));
				array_push(_arr_return_deck,scr_card_get_info("POLLINATE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("MIRACLE_MUSA"));
						array_push(_arr_return_deck,scr_card_get_info("SAPSPRING"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("LIFEBLOOM"));
						array_push(_arr_return_deck,scr_card_get_info("SECOND_BLOOM"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("VIRIDIAN_BURST"));
						array_push(_arr_return_deck,scr_card_get_info("SPIT_VENOM"));
					break;
				}

			break;
			#endregion


			#region MAMBARK
			case "MAMBARK":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("SPIRIT_FANG"));
				array_push(_arr_return_deck,scr_card_get_info("NATURES_WRATH"));
				array_push(_arr_return_deck,scr_card_get_info("SPIRIT_PIERCE"));
				array_push(_arr_return_deck,scr_card_get_info("PREDATORS_MARK"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("VENOM_BLOOM"));
						array_push(_arr_return_deck,scr_card_get_info("WILT"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("NATURES_FURY"));
						array_push(_arr_return_deck,scr_card_get_info("BIOBOLT"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("PREDATORY_SCENT"));
						array_push(_arr_return_deck,scr_card_get_info("HUNTERS_INSTINCT"));
					break;
				}

			break;
			#endregion


			#region MORELUSH
			case "MORELUSH":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("GREENFLOW"));
				array_push(_arr_return_deck,scr_card_get_info("SPORE_CLOUD"));
				array_push(_arr_return_deck,scr_card_get_info("ROT_BLOOM"));
				array_push(_arr_return_deck,scr_card_get_info("CULTIVATE"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("POTENT_SPORE"));
						array_push(_arr_return_deck,scr_card_get_info("BURGEONING_BLOOM"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("DRAINING_KISS"));
						array_push(_arr_return_deck,scr_card_get_info("REJUVENATE"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("SERPENT_SUMMON"));
						array_push(_arr_return_deck,scr_card_get_info("POTENT_SPORE"));
					break;
				}

			break;
			#endregion


			#region SPOROSE
			case "SPOROSE":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("SPORE_CLOUD"));
				array_push(_arr_return_deck,scr_card_get_info("VERDANT_BOLT"));
				array_push(_arr_return_deck,scr_card_get_info("NATURES_WRATH"));
				array_push(_arr_return_deck,scr_card_get_info("DECAYING_TOUCH"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("BRAMBLE_ERUPTION"));
						array_push(_arr_return_deck,scr_card_get_info("SHIMMERING_SPORES"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("SPIRIT_FANG"));
						array_push(_arr_return_deck,scr_card_get_info("POLLINATE"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("PRIMAL_BLAST"));
						array_push(_arr_return_deck,scr_card_get_info("CLAW"));
					break;
				}

			break;
			#endregion


			#region STRIGIBLOOM
			case "STRIGIBLOOM":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("SPIKE_PIERCE"));
				array_push(_arr_return_deck,scr_card_get_info("VIRIDIAN_BURST"));
				array_push(_arr_return_deck,scr_card_get_info("CLAW"));
				array_push(_arr_return_deck,scr_card_get_info("THORN_NET"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("SLEEPING_POLLEN"));
						array_push(_arr_return_deck,scr_card_get_info("BLOOMTIDE"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("NATURES_MEND"));
						array_push(_arr_return_deck,scr_card_get_info("CURE_ALL"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("SNARLING_BITE"));
						array_push(_arr_return_deck,scr_card_get_info("SPINESLING"));
					break;
				}

			break;
			#endregion


			#region TURFRANTULA
			case "TURFRANTULA":

				//========//
				//SHARED//
				//========//
				array_push(_arr_return_deck,scr_card_get_info("GREENFLOW"));
				array_push(_arr_return_deck,scr_card_get_info("SPIT_VENOM"));
				array_push(_arr_return_deck,scr_card_get_info("ROT_BLOOM"));
				array_push(_arr_return_deck,scr_card_get_info("GROWTH_SIGIL"));

				//=========//
				//SUBTYPE//
				//=========//
				switch (_str_beast_type){

					case "BOTANICAL":
						array_push(_arr_return_deck,scr_card_get_info("SPORE_CLOUD"));
						array_push(_arr_return_deck,scr_card_get_info("LIFEBLOOM"));
					break;

					case "NATURAL":
						array_push(_arr_return_deck,scr_card_get_info("BURGEONING_BLOOM"));
						array_push(_arr_return_deck,scr_card_get_info("LIFE_SPIRIT"));
					break;

					case "WILD":
						array_push(_arr_return_deck,scr_card_get_info("VENOM_BLOOM"));
						array_push(_arr_return_deck,scr_card_get_info("DECAYING_TOUCH"));
					break;
				}

			break;
			#endregion

		#endregion
	}

	//================//
	//FALLBACK DECK//
	//================//
	if (array_length(_arr_return_deck) <= 0){
		array_push(_arr_return_deck,scr_card_get_info("STRIKE"));
	}

	return _arr_return_deck;
}