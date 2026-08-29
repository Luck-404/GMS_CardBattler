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

			#region ARBRAWN
			case "ARBRAWN":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("CLAW"));
				ds_list_add(_list_return_deck,scr_get_card_info("BARKSKIN"));
				ds_list_add(_list_return_deck,scr_get_card_info("BEASTIAL_WRATH"));
				ds_list_add(_list_return_deck,scr_get_card_info("SAVAGE_MAUL"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));
						ds_list_add(_list_return_deck,scr_get_card_info("THORNMAIL"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_BOND"));
						ds_list_add(_list_return_deck,scr_get_card_info("REGENERATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("RAKE"));
						ds_list_add(_list_return_deck,scr_get_card_info("SPIT_VENOM"));
					break;
				}

			break;
			#endregion


			#region ARGENTBUD
			case "ARGENTBUD":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("DORMANT_SEED"));
				ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));
				ds_list_add(_list_return_deck,scr_get_card_info("BLOWDART"));
				ds_list_add(_list_return_deck,scr_get_card_info("BLOOMING_SHIELD"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("CULTIVATE"));
						ds_list_add(_list_return_deck,scr_get_card_info("BRAMBLE_HIDE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("LIFEBLOOM"));
						ds_list_add(_list_return_deck,scr_get_card_info("GERMINATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("SPIT_VENOM"));
						ds_list_add(_list_return_deck,scr_get_card_info("VIRAL_SURGE"));
					break;
				}

			break;
			#endregion


			#region BEAVINE
			case "BEAVINE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("SPINESLING"));
				ds_list_add(_list_return_deck,scr_get_card_info("DORMANT_SEED"));
				ds_list_add(_list_return_deck,scr_get_card_info("CRIPPLING_VINES"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("CULTIVATE"));
						ds_list_add(_list_return_deck,scr_get_card_info("ENTANGLE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("LIFEBLOOM"));
						ds_list_add(_list_return_deck,scr_get_card_info("REGENERATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("VIRIDIAN_BURST"));
						ds_list_add(_list_return_deck,scr_get_card_info("TOXIC_HIDE"));
					break;
				}

			break;
			#endregion


			#region BRYOBITE
			case "BRYOBITE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("CLAW"));
				ds_list_add(_list_return_deck,scr_get_card_info("BARKSKIN"));
				ds_list_add(_list_return_deck,scr_get_card_info("LIFE_SPIRIT"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("THORNMAIL"));
						ds_list_add(_list_return_deck,scr_get_card_info("BRAMBLE_HIDE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_GRACE"));
						ds_list_add(_list_return_deck,scr_get_card_info("ROOTED_DEFENSE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("BLOWDART"));
						ds_list_add(_list_return_deck,scr_get_card_info("VIRAL_SURGE"));
					break;
				}

			break;
			#endregion


			#region CHITROOPER
			case "CHITROOPER":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("FERAL_FRENZY"));
				ds_list_add(_list_return_deck,scr_get_card_info("INTERLOCKING_SCALES"));
				ds_list_add(_list_return_deck,scr_get_card_info("PHEROMONES"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("OVERGROWTH"));
						ds_list_add(_list_return_deck,scr_get_card_info("DORMANT_SEED"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_GRACE"));
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_MEND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("SNARLING_BITE"));
						ds_list_add(_list_return_deck,scr_get_card_info("DISEASE"));
					break;
				}

			break;
			#endregion


			#region CRUSABER
			case "CRUSABER":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("STALKING_SWIPE"));
				ds_list_add(_list_return_deck,scr_get_card_info("THICK_HIDE"));
				ds_list_add(_list_return_deck,scr_get_card_info("SYMBIOSIS"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("SINEWY_VINES"));
						ds_list_add(_list_return_deck,scr_get_card_info("EMERALD_SLAM"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("GREENSTEP"));
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_MEND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("PREDATORS_MARK"));
						ds_list_add(_list_return_deck,scr_get_card_info("SNARLING_BITE"));
					break;
				}

			break;
			#endregion


			#region DRYADAE
			case "DRYADAE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("VERDANT_BOLT"));
				ds_list_add(_list_return_deck,scr_get_card_info("BLOOMING_SPRITE"));
				ds_list_add(_list_return_deck,scr_get_card_info("SHIMMERING_SPORES"));
				ds_list_add(_list_return_deck,scr_get_card_info("SLEEPING_POLLEN"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("DORMANT_SEED"));
						ds_list_add(_list_return_deck,scr_get_card_info("GREENFLOW"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("BURGEONING_BLOOM"));
						ds_list_add(_list_return_deck,scr_get_card_info("SAPSPRING"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("POTENT_SPORE"));
						ds_list_add(_list_return_deck,scr_get_card_info("DECAYING_TOUCH"));
					break;
				}

			break;
			#endregion


			#region FIGHTREE
			case "FIGHTREE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("FELL"));
				ds_list_add(_list_return_deck,scr_get_card_info("STEELFUR"));
				ds_list_add(_list_return_deck,scr_get_card_info("PHEROMONES"));
				ds_list_add(_list_return_deck,scr_get_card_info("OLD_GROWTH_PUMMEL"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("OVERGROWTH"));
						ds_list_add(_list_return_deck,scr_get_card_info("EMERALD_SLAM"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("CURE_ALL"));
						ds_list_add(_list_return_deck,scr_get_card_info("LIFEBLOOM"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("TOXIC_HIDE"));
						ds_list_add(_list_return_deck,scr_get_card_info("THORN_NET"));
					break;
				}

			break;
			#endregion


			#region FLITSAGE
			case "FLITSAGE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("BIOBOLT"));
				ds_list_add(_list_return_deck,scr_get_card_info("PRIMAL_BLAST"));
				ds_list_add(_list_return_deck,scr_get_card_info("MIRACLE_MUSA"));
				ds_list_add(_list_return_deck,scr_get_card_info("SPIRIT_PIERCE"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("BRAMBLE_ERUPTION"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOOMING_SPRITE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("REJUVENATE"));
						ds_list_add(_list_return_deck,scr_get_card_info("POLLINATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("SPIRIT_FANG"));
						ds_list_add(_list_return_deck,scr_get_card_info("WILT"));
					break;
				}

			break;
			#endregion


			#region FURN
			case "FURN":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("RAKE"));
				ds_list_add(_list_return_deck,scr_get_card_info("HUNTERS_INSTINCT"));
				ds_list_add(_list_return_deck,scr_get_card_info("PREDATORS_MARK"));
				ds_list_add(_list_return_deck,scr_get_card_info("HUNTERS_JAVELIN"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("THORN_NET"));
						ds_list_add(_list_return_deck,scr_get_card_info("BURSTING_SEED"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("GREENSTEP"));
						ds_list_add(_list_return_deck,scr_get_card_info("NATURAL_RECOVERY"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("SPIT_VENOM"));
						ds_list_add(_list_return_deck,scr_get_card_info("TOXIC_SNARE"));
					break;
				}

			break;
			#endregion


			#region LEPOROOT
			case "LEPOROOT":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("SPIKE_PIERCE"));
				ds_list_add(_list_return_deck,scr_get_card_info("GREENSTEP"));
				ds_list_add(_list_return_deck,scr_get_card_info("POTENT_FRUIT"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("DORMANT_SEED"));
						ds_list_add(_list_return_deck,scr_get_card_info("CULTIVATE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("DRAINING_KISS"));
						ds_list_add(_list_return_deck,scr_get_card_info("CURE_ALL"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("ROTTING_SPORES"));
						ds_list_add(_list_return_deck,scr_get_card_info("VENOM_BLOOM"));
					break;
				}

			break;
			#endregion


			#region LUMBUCK
			case "LUMBUCK":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("VERDANT_SWIPES"));
				ds_list_add(_list_return_deck,scr_get_card_info("VERDANT_INSIGHT"));
				ds_list_add(_list_return_deck,scr_get_card_info("SECOND_BLOOM"));
				ds_list_add(_list_return_deck,scr_get_card_info("WILDSTRIKE"));
				ds_list_add(_list_return_deck,scr_get_card_info("WILD_VIGOR"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("BLOOMING_SPRITE"));
						ds_list_add(_list_return_deck,scr_get_card_info("SINEWY_VINES"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("BURGEONING_BLOOM"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOOMTIDE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("SPIRIT_FANG"));
						ds_list_add(_list_return_deck,scr_get_card_info("DISEASE"));
					break;
				}

			break;
			#endregion


			#region MAMBARK
			case "MAMBARK":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("UNSEEN_ROOT"));
				ds_list_add(_list_return_deck,scr_get_card_info("PREDATORS_MARK"));
				ds_list_add(_list_return_deck,scr_get_card_info("SHIMMERING_SPORES"));
				ds_list_add(_list_return_deck,scr_get_card_info("NATURES_FURY"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("BLOOMING_SPRITE"));
						ds_list_add(_list_return_deck,scr_get_card_info("BURSTING_SEED"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_MEND"));
						ds_list_add(_list_return_deck,scr_get_card_info("SECOND_BLOOM"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("POTENT_SPORE"));
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_WRATH"));
					break;
				}

			break;
			#endregion


			#region MORELUSH
			case "MORELUSH":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("SPORE_CLOUD"));
				ds_list_add(_list_return_deck,scr_get_card_info("DORMANT_SEED"));
				ds_list_add(_list_return_deck,scr_get_card_info("BLOOMING_SPRITE"));
				ds_list_add(_list_return_deck,scr_get_card_info("SYMBIOSIS"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("GERMINATE"));
						ds_list_add(_list_return_deck,scr_get_card_info("GREENFLOW"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_MEND"));
						ds_list_add(_list_return_deck,scr_get_card_info("REJUVENATE"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("SERPENT_SUMMON"));
						ds_list_add(_list_return_deck,scr_get_card_info("VENOM_BLOOM"));
					break;
				}

			break;
			#endregion


			#region SPOROSE
			case "SPOROSE":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("BIOBOLT"));
				ds_list_add(_list_return_deck,scr_get_card_info("VERDANT_INSIGHT"));
				ds_list_add(_list_return_deck,scr_get_card_info("NATURAL_RECOVERY"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("BURGEONING_BLOOM"));
						ds_list_add(_list_return_deck,scr_get_card_info("MIRACLE_MUSA"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("DRAINING_KISS"));
						ds_list_add(_list_return_deck,scr_get_card_info("CURE_ALL"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("POTENT_SPORE"));
						ds_list_add(_list_return_deck,scr_get_card_info("TOXIC_SNARE"));
					break;
				}

			break;
			#endregion


			#region STRIGIBLOOM
			case "STRIGIBLOOM":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("UNSEEN_ROOT"));
				ds_list_add(_list_return_deck,scr_get_card_info("SLEEP_DART"));
				ds_list_add(_list_return_deck,scr_get_card_info("PREDATORS_MARK"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("DORMANT_SEED"));
						ds_list_add(_list_return_deck,scr_get_card_info("POTENT_FRUIT"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_MEND"));
						ds_list_add(_list_return_deck,scr_get_card_info("SECOND_BLOOM"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("SPIRIT_FANG"));
						ds_list_add(_list_return_deck,scr_get_card_info("ROTTING_SPORES"));
					break;
				}

			break;
			#endregion


			#region TURFRANTULA
			case "TURFRANTULA":

				//--------//
				// SHARED //
				//--------//
				ds_list_add(_list_return_deck,scr_get_card_info("SPORE_CLOUD"));
				ds_list_add(_list_return_deck,scr_get_card_info("DORMANT_SEED"));
				ds_list_add(_list_return_deck,scr_get_card_info("GROWTH_SIGIL"));
				ds_list_add(_list_return_deck,scr_get_card_info("ROTTING_SPORES"));

				//---------//
				// SUBTYPE //
				//---------//
				switch(_str_beast_type){

					case "BOTANICAL":
						ds_list_add(_list_return_deck,scr_get_card_info("GERMINATE"));
						ds_list_add(_list_return_deck,scr_get_card_info("BLOOMING_SPRITE"));
					break;

					case "NATURAL":
						ds_list_add(_list_return_deck,scr_get_card_info("POLLINATE"));
						ds_list_add(_list_return_deck,scr_get_card_info("NATURES_MEND"));
					break;

					case "WILD":
						ds_list_add(_list_return_deck,scr_get_card_info("TOXIC_SNARE"));
						ds_list_add(_list_return_deck,scr_get_card_info("VENOM_BLOOM"));
					break;
				}

			break;
			#endregion

		#endregion
	}

	if (ds_list_size(_list_return_deck) <= 0){
		ds_list_add(_list_return_deck,scr_get_card_info("STRIKE"));
	}

	return _list_return_deck;
}