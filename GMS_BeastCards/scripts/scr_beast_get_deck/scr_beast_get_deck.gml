function scr_beast_get_deck(_str_beast_name,_str_beast_type){

	var _list_return_deck = ds_list_create();

	switch (_str_beast_name){

		#region CERULEAN

			#region AMMOMARSH
			case "AMMOMARSH":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
				ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_SHELL"));
				ds_list_add(_list_return_deck,scr_card_get_info("OCEANS_BLESSING"));
				ds_list_add(_list_return_deck,scr_card_get_info("SHELL_SHIELD"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_WALL"));
						ds_list_add(_list_return_deck,scr_card_get_info("WHIRLPOOL"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROSTBOLT"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_PRISON"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("RAIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("CRYSTAL_SHELL"));
					break;
				}

			break;
			#endregion


			#region BLIZZDRIFT
			case "BLIZZDRIFT":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("HAILSTONES"));
				ds_list_add(_list_return_deck,scr_card_get_info("BARRIER"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_PRECISION"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
						ds_list_add(_list_return_deck,scr_card_get_info("COLD_SNAP"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("BITTER_CHILL"));
						ds_list_add(_list_return_deck,scr_card_get_info("WINTER_RESONANCE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("DEPTH_CHARGE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SNOWFALL"));
					break;
				}

			break;
			#endregion


			#region CAUDAQUA
			case "CAUDAQUA":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_LANCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("AQUA_STEP"));
				ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_RECOVERY"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("PURIFY_WATERS"));
						ds_list_add(_list_return_deck,scr_card_get_info("PERMAFROST"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROSTBOLT"));
						ds_list_add(_list_return_deck,scr_card_get_info("BRITTLE_CONSTITUTION"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("RAIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("UNDERTOW"));
					break;
				}

			break;
			#endregion


			#region CEPHARIME
			case "CEPHARIME":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("TORRENT"));
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_MIRROR"));
				ds_list_add(_list_return_deck,scr_card_get_info("WHITEOUT"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("CHILLING_WEAKNESS"));
						ds_list_add(_list_return_deck,scr_card_get_info("CORAL_GUARDIAN"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("BITTER_CHILL"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_PRISON"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("UNDERTOW"));
						ds_list_add(_list_return_deck,scr_card_get_info("RIP_CURRENT"));
					break;
				}

			break;
			#endregion


			#region CHELONSEA
			case "CHELONSEA":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("BURST"));
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_PLATING"));
				ds_list_add(_list_return_deck,scr_card_get_info("CORAL_GUARDIAN"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_WALL"));
						ds_list_add(_list_return_deck,scr_card_get_info("SHARED_BULWARK"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("RIMEFROST_ELEMENTAL"));
						ds_list_add(_list_return_deck,scr_card_get_info("THIN_ICE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_HARPOON"));
						ds_list_add(_list_return_deck,scr_card_get_info("STORM_BEACON"));
					break;
				}

			break;
			#endregion


			#region CORALLIARC
			case "CORALLIARC":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("STORM_WISP"));
				ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_HARPOON"));
				ds_list_add(_list_return_deck,scr_card_get_info("SHELL_SHIELD"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("ANCHOR_STONE"));
						ds_list_add(_list_return_deck,scr_card_get_info("ARMOR_TRANSFER"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("RIMEFROST_ELEMENTAL"));
						ds_list_add(_list_return_deck,scr_card_get_info("SNOWFORT"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("STORM_BEACON"));
						ds_list_add(_list_return_deck,scr_card_get_info("SEA_LEGS"));
					break;
				}

			break;
			#endregion


			#region FROSTUSK
			case "FROSTUSK":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_FANG"));
				ds_list_add(_list_return_deck,scr_card_get_info("COOLING_MIST"));
				ds_list_add(_list_return_deck,scr_card_get_info("SEA_LEGS"));
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_PLATING"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("CHILLING_WEAKNESS"));
						ds_list_add(_list_return_deck,scr_card_get_info("HYPOTHERMIA"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_ACCRETION"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROST_WEAPON"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("CRASHING_WAVE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SNOWFALL"));
					break;
				}

			break;
			#endregion


			#region GALENATRIUM
			case "GALENATRIUM":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
				ds_list_add(_list_return_deck,scr_card_get_info("BUBBLE"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_PRECISION"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("WHIRLPOOL"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROSTBURN_NOVA"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("ABSOLUTE_ZERO"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_PRISON"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("RAIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("DEPTH_CHARGE"));
					break;
				}

			break;
			#endregion


			#region GLACIMIGHT
			case "GLACIMIGHT":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
				ds_list_add(_list_return_deck,scr_card_get_info("BUBBLE"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_PRECISION"));
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_PLATING"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("WHIRLPOOL"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_ARMOR"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("SHATTER_STRIKE"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICE_PRISON"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("THUNDERSTORM"));
						ds_list_add(_list_return_deck,scr_card_get_info("STATIC_BARRIER"));
					break;
				}

			break;
			#endregion


			#region GULFLOW
			case "GULFLOW":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("ABYSSAL_TOUCH"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_BULWARK"));
				ds_list_add(_list_return_deck,scr_card_get_info("SAILORS_RESOLVE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SOOTHING_CURRENT"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("HYPOTHERMIA"));
						ds_list_add(_list_return_deck,scr_card_get_info("MARINE_MEND"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("CRYOGENIC_RECOVERY"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROSTBOLT"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("CALM_SEAS"));
						ds_list_add(_list_return_deck,scr_card_get_info("AQUA_STEP"));
					break;
				}

			break;
			#endregion


			#region ISTIRAIN
			case "ISTIRAIN":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_FIN"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_SPEAR"));
				ds_list_add(_list_return_deck,scr_card_get_info("ARCTIC_FOCUS"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_CRUSH"));
						ds_list_add(_list_return_deck,scr_card_get_info("PERMAFROST"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_FANG"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROST_WEAPON"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("RAIN"));
						ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_SLASH"));
					break;
				}

			break;
			#endregion


			#region KELPLATANI
			case "KELPLATANI":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("STORM_WISP"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_BULWARK"));
				ds_list_add(_list_return_deck,scr_card_get_info("SAILORS_RESOLVE"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("SHARED_BULWARK"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICEBOUND_SEAL"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROST_WEAPON"));
						ds_list_add(_list_return_deck,scr_card_get_info("THIN_ICE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("AQUA_STEP"));
						ds_list_add(_list_return_deck,scr_card_get_info("UNDERTOW"));
					break;
				}

			break;
			#endregion


			#region LONTRIVER
			case "LONTRIVER":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_SLASH"));
				ds_list_add(_list_return_deck,scr_card_get_info("SNOWDRIFT"));
				ds_list_add(_list_return_deck,scr_card_get_info("BUBBLE"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("TORRENT"));
						ds_list_add(_list_return_deck,scr_card_get_info("ARCTIC_FOCUS"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("GLACIAL_ERUPTION"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_CURSE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("RIP_CURRENT"));
						ds_list_add(_list_return_deck,scr_card_get_info("ROUGH_SEAS"));
					break;
				}

			break;
			#endregion


			#region MARITIMICE
			case "MARITIMICE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("AVALANCHE_STRIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SNOWDRIFT"));
				ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_BASTION"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("ARCTIC_VOLLEY"));
						ds_list_add(_list_return_deck,scr_card_get_info("ARCTIC_FOCUS"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_ARMOR"));
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_CURSE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("RIP_CURRENT"));
						ds_list_add(_list_return_deck,scr_card_get_info("ROUGH_SEAS"));
					break;
				}

			break;
			#endregion


			#region SALTWAGG
			case "SALTWAGG":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("GLACIAL_CRUSH"));
				ds_list_add(_list_return_deck,scr_card_get_info("RAZOR_SHELL"));
				ds_list_add(_list_return_deck,scr_card_get_info("COLD_RESERVE"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("TIDAL_BREAK"));
						ds_list_add(_list_return_deck,scr_card_get_info("CHILLING_WEAKNESS"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROZEN_FANG"));
						ds_list_add(_list_return_deck,scr_card_get_info("WINTERS_BITE"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("KRAKENSLAM"));
						ds_list_add(_list_return_deck,scr_card_get_info("WHITEWATER"));
					break;
				}

			break;
			#endregion


			#region SPHENISKIP
			case "SPHENISKIP":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("PRESSURE_SPIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("AQUA_STEP"));
				ds_list_add(_list_return_deck,scr_card_get_info("ICE_MIRROR"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "ABYSS":
						ds_list_add(_list_return_deck,scr_card_get_info("PURIFY_WATERS"));
						ds_list_add(_list_return_deck,scr_card_get_info("WHIRLPOOL"));
					break;

					case "FROST":
						ds_list_add(_list_return_deck,scr_card_get_info("FROSTBOLT"));
						ds_list_add(_list_return_deck,scr_card_get_info("ICEBOUND_INSTINCT"));
					break;

					case "WAVE":
						ds_list_add(_list_return_deck,scr_card_get_info("DROP_ANCHOR"));
						ds_list_add(_list_return_deck,scr_card_get_info("SNOWFORT"));
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

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("CLAW"));
				ds_list_add(_list_return_deck,scr_card_get_info("BARKSKIN"));
				ds_list_add(_list_return_deck,scr_card_get_info("BEASTIAL_WRATH"));
				ds_list_add(_list_return_deck,scr_card_get_info("SAVAGE_MAUL"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_card_get_info("THORNMAIL"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_BOND"));
						ds_list_add(_list_return_deck,scr_card_get_info("REGENERATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("RAKE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SPIT_VENOM"));
					break;
				}

			break;
			#endregion


			#region ARGENTBUD
			case "ARGENTBUD":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
				ds_list_add(_list_return_deck,scr_card_get_info("LIFE_SPIRIT"));
				ds_list_add(_list_return_deck,scr_card_get_info("BLOWDART"));
				ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SHIELD"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("CULTIVATE"));
						ds_list_add(_list_return_deck,scr_card_get_info("BRAMBLE_HIDE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("LIFEBLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("GERMINATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SPIT_VENOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("VIRAL_SURGE"));
					break;
				}

			break;
			#endregion


			#region BEAVINE
			case "BEAVINE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("SPINESLING"));
				ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
				ds_list_add(_list_return_deck,scr_card_get_info("CRIPPLING_VINES"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("CULTIVATE"));
						ds_list_add(_list_return_deck,scr_card_get_info("ENTANGLE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("LIFEBLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("REGENERATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("VIRIDIAN_BURST"));
						ds_list_add(_list_return_deck,scr_card_get_info("TOXIC_HIDE"));
					break;
				}

			break;
			#endregion


			#region BRYOBITE
			case "BRYOBITE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("CLAW"));
				ds_list_add(_list_return_deck,scr_card_get_info("BARKSKIN"));
				ds_list_add(_list_return_deck,scr_card_get_info("LIFE_SPIRIT"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("THORNMAIL"));
						ds_list_add(_list_return_deck,scr_card_get_info("BRAMBLE_HIDE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_GRACE"));
						ds_list_add(_list_return_deck,scr_card_get_info("ROOTED_DEFENSE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("BLOWDART"));
						ds_list_add(_list_return_deck,scr_card_get_info("VIRAL_SURGE"));
					break;
				}

			break;
			#endregion


			#region CHITROOPER
			case "CHITROOPER":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("FERAL_FRENZY"));
				ds_list_add(_list_return_deck,scr_card_get_info("INTERLOCKING_SCALES"));
				ds_list_add(_list_return_deck,scr_card_get_info("PHEROMONES"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("OVERGROWTH"));
						ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_GRACE"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_MEND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SNARLING_BITE"));
						ds_list_add(_list_return_deck,scr_card_get_info("DISEASE"));
					break;
				}

			break;
			#endregion


			#region CRUSABER
			case "CRUSABER":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("STALKING_SWIPE"));
				ds_list_add(_list_return_deck,scr_card_get_info("THICK_HIDE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SYMBIOSIS"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("SINEWY_VINES"));
						ds_list_add(_list_return_deck,scr_card_get_info("EMERALD_SLAM"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("GREENSTEP"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_MEND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("WILD_VIGOR"));
						ds_list_add(_list_return_deck,scr_card_get_info("SNARLING_BITE"));
					break;
				}

			break;
			#endregion


			#region DRYADAE
			case "DRYADAE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_BOLT"));
				ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SPRITE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SHIMMERING_SPORES"));
				ds_list_add(_list_return_deck,scr_card_get_info("SLEEPING_POLLEN"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
						ds_list_add(_list_return_deck,scr_card_get_info("GREENFLOW"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BURGEONING_BLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("SAPSPRING"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("POTENT_SPORE"));
						ds_list_add(_list_return_deck,scr_card_get_info("DECAYING_TOUCH"));
					break;
				}

			break;
			#endregion


			#region FIGHTREE
			case "FIGHTREE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("FELL"));
				ds_list_add(_list_return_deck,scr_card_get_info("STEELFUR"));
				ds_list_add(_list_return_deck,scr_card_get_info("PHEROMONES"));
				ds_list_add(_list_return_deck,scr_card_get_info("OLD_GROWTH_PUMMEL"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("OVERGROWTH"));
						ds_list_add(_list_return_deck,scr_card_get_info("EMERALD_SLAM"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("CURE_ALL"));
						ds_list_add(_list_return_deck,scr_card_get_info("LIFEBLOOM"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("TOXIC_HIDE"));
						ds_list_add(_list_return_deck,scr_card_get_info("WILDSTRIKE"));
					break;
				}

			break;
			#endregion


			#region FLITSAGE
			case "FLITSAGE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("BIOBOLT"));
				ds_list_add(_list_return_deck,scr_card_get_info("PRIMAL_BLAST"));
				ds_list_add(_list_return_deck,scr_card_get_info("MIRACLE_MUSA"));
				ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_PIERCE"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BRAMBLE_ERUPTION"));
						ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SPRITE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("REJUVENATE"));
						ds_list_add(_list_return_deck,scr_card_get_info("POLLINATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_FANG"));
						ds_list_add(_list_return_deck,scr_card_get_info("WILT"));
					break;
				}

			break;
			#endregion


			#region FURN
			case "FURN":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("RAKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("HUNTERS_INSTINCT"));
				ds_list_add(_list_return_deck,scr_card_get_info("PREDATORS_MARK"));
				ds_list_add(_list_return_deck,scr_card_get_info("HUNTERS_JAVELIN"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("THORN_NET"));
						ds_list_add(_list_return_deck,scr_card_get_info("BURSTING_SEED"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("GREENSTEP"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURAL_RECOVERY"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SPIT_VENOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("TOXIC_SNARE"));
					break;
				}

			break;
			#endregion


			#region LEPOROOT
			case "LEPOROOT":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("SPIKE_PIERCE"));
				ds_list_add(_list_return_deck,scr_card_get_info("GREENSTEP"));
				ds_list_add(_list_return_deck,scr_card_get_info("POTENT_FRUIT"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
						ds_list_add(_list_return_deck,scr_card_get_info("CULTIVATE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("DRAINING_KISS"));
						ds_list_add(_list_return_deck,scr_card_get_info("CURE_ALL"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("ROTTING_SPORES"));
						ds_list_add(_list_return_deck,scr_card_get_info("VENOM_BLOOM"));
					break;
				}

			break;
			#endregion


			#region LUMBUCK
			case "LUMBUCK":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_SWIPES"));
				ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_INSIGHT"));
				ds_list_add(_list_return_deck,scr_card_get_info("SECOND_BLOOM"));
				ds_list_add(_list_return_deck,scr_card_get_info("WILDSTRIKE"));
				ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SHIELD"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SPRITE"));
						ds_list_add(_list_return_deck,scr_card_get_info("SINEWY_VINES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BURGEONING_BLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("BLOOMTIDE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_FANG"));
						ds_list_add(_list_return_deck,scr_card_get_info("DISEASE"));
					break;
				}

			break;
			#endregion


			#region MAMBARK
			case "MAMBARK":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("UNSEEN_ROOT"));
				ds_list_add(_list_return_deck,scr_card_get_info("PREDATORS_MARK"));
				ds_list_add(_list_return_deck,scr_card_get_info("SHIMMERING_SPORES"));
				ds_list_add(_list_return_deck,scr_card_get_info("NATURES_FURY"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SPRITE"));
						ds_list_add(_list_return_deck,scr_card_get_info("BURSTING_SEED"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_MEND"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_BOND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("POTENT_SPORE"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_WRATH"));
					break;
				}

			break;
			#endregion


			#region MORELUSH
			case "MORELUSH":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("SPORE_CLOUD"));
				ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
				ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SPRITE"));
				ds_list_add(_list_return_deck,scr_card_get_info("SYMBIOSIS"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("GERMINATE"));
						ds_list_add(_list_return_deck,scr_card_get_info("GREENFLOW"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_MEND"));
						ds_list_add(_list_return_deck,scr_card_get_info("REJUVENATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SERPENT_SUMMON"));
						ds_list_add(_list_return_deck,scr_card_get_info("VENOM_BLOOM"));
					break;
				}

			break;
			#endregion


			#region SPOROSE
			case "SPOROSE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("BIOBOLT"));
				ds_list_add(_list_return_deck,scr_card_get_info("VERDANT_INSIGHT"));
				ds_list_add(_list_return_deck,scr_card_get_info("NATURAL_RECOVERY"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("BURGEONING_BLOOM"));
						ds_list_add(_list_return_deck,scr_card_get_info("MIRACLE_MUSA"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("DRAINING_KISS"));
						ds_list_add(_list_return_deck,scr_card_get_info("CURE_ALL"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("POTENT_SPORE"));
						ds_list_add(_list_return_deck,scr_card_get_info("DECAYING_TOUCH"));
					break;
				}

			break;
			#endregion


			#region STRIGIBLOOM
			case "STRIGIBLOOM":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("UNSEEN_ROOT"));
				ds_list_add(_list_return_deck,scr_card_get_info("SLEEP_DART"));
				ds_list_add(_list_return_deck,scr_card_get_info("THORN_NET"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
						ds_list_add(_list_return_deck,scr_card_get_info("POTENT_FRUIT"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_MEND"));
						ds_list_add(_list_return_deck,scr_card_get_info("SECOND_BLOOM"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SPIRIT_FANG"));
						ds_list_add(_list_return_deck,scr_card_get_info("ROTTING_SPORES"));
					break;
				}

			break;
			#endregion


			#region TURFRANTULA
			case "TURFRANTULA":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_card_get_info("SPORE_CLOUD"));
				ds_list_add(_list_return_deck,scr_card_get_info("DORMANT_SEED"));
				ds_list_add(_list_return_deck,scr_card_get_info("GROWTH_SIGIL"));
				ds_list_add(_list_return_deck,scr_card_get_info("PACK_INSTINCT"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_card_get_info("GERMINATE"));
						ds_list_add(_list_return_deck,scr_card_get_info("BLOOMING_SPRITE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_card_get_info("POLLINATE"));
						ds_list_add(_list_return_deck,scr_card_get_info("NATURES_MEND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_card_get_info("SERPENT_SUMMON"));
						ds_list_add(_list_return_deck,scr_card_get_info("VENOM_BLOOM"));
					break;
				}

			break;
			#endregion

		#endregion
	}

	if (ds_list_size(_list_return_deck) <= 0){
		ds_list_add(_list_return_deck,scr_card_get_info("STRIKE"));
	}

	return _list_return_deck;
}