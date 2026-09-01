//===============================================================================//
//
// SCRIPT: SCR_INIT_LOGBOOK_CARDS
// FUNCTION: Initializes the card logbook catalog.
//           Creates one persistent logbook entry for each known card ID.
//           Stores entries in both ordered list and lookup map.
//
//===============================================================================//

function scr_init_logbook_cards(){

	//-----------------------------//
	//RESET EXISTING LOGBOOK DATA//
	//-----------------------------//
	ds_list_clear(global.list_logbook_cards);
	ds_map_clear(global.map_logbook_cards);


	//----------------------------//
	//LOCAL HELPER: ADD CARD ENTRY//
	//----------------------------//
	function hscr_add_card_entry(_str_card_id,_str_color_group){

		//------------------//
		//PREVENT DUPLICATES//
		//------------------//
		if (ds_map_exists(global.map_logbook_cards,_str_card_id)){
			return;
		}

		//-------------//
		//GET CARD INFO//
		//-------------//
		var _stct_card_info = scr_get_card_info(_str_card_id);

		var _flag_has_card_info =
			(_stct_card_info != undefined);

		//-------------------//
		//MISSING CARD DEBUG//
		//-------------------//
		if (!_flag_has_card_info){

			show_debug_message(
				"LOGBOOK WARNING: MISSING CARD INFO | " +
				_str_card_id
			);
		}

		//--------------------//
		//CREATE LOGBOOK ENTRY//
		//--------------------//
		var _stct_entry = {

			_str_card_id :
				_str_card_id,

			_str_card_name :
				_str_card_id,

			_str_color_group :
				_str_color_group,

			_stct_card_info :
				_stct_card_info,

			_flag_has_card_info :
				_flag_has_card_info,

			_flag_seen :
				false,

			_flag_obtained :
				false,

			_ct_seen :
				0,

			_ct_obtained :
				0
		};

		//------------------//
		//SET DISPLAY NAME//
		//------------------//
		if (_flag_has_card_info){

			_stct_entry._str_card_name =
				_stct_card_info._str_card_name;
		}

		//----------------//
		//REGISTER ENTRY//
		//----------------//
		ds_list_add(global.list_logbook_cards,_stct_entry);

		global.map_logbook_cards[? _str_card_id] =
			_stct_entry;
	}


	//===============================================================================//
	//
	// UNCOLORED
	//
	//===============================================================================//
	#region UNCOLORED

	hscr_add_card_entry("HIDDEN_CARD","UNCOLORED");

	hscr_add_card_entry("STRIKE","UNCOLORED");
	hscr_add_card_entry("POWER_STRIKE","UNCOLORED");
	hscr_add_card_entry("RAPID_STRIKES","UNCOLORED");
	hscr_add_card_entry("DEFT_STRIKE","UNCOLORED");
	hscr_add_card_entry("SHIV","UNCOLORED");
	hscr_add_card_entry("SPELLBOOK_WILDCARD","UNCOLORED");

	hscr_add_card_entry("BLOCK","UNCOLORED");
	hscr_add_card_entry("BULWARK","UNCOLORED");

	hscr_add_card_entry("INSPIRATION","UNCOLORED");
	hscr_add_card_entry("MALLEABILITY","UNCOLORED");

	hscr_add_card_entry("ECHO","UNCOLORED");
	hscr_add_card_entry("REPOSITION","UNCOLORED");
	hscr_add_card_entry("CLEARCAST","UNCOLORED");
	hscr_add_card_entry("THOUGHTSTEAL","UNCOLORED");
	hscr_add_card_entry("ARTIFACT_HOURGLASS","UNCOLORED");

	#endregion


	//===============================================================================//
	//
	// VIRIDIAN
	//
	//===============================================================================//
	#region VIRIDIAN


	//===============================================================================//
	//
	// ATTACK - DIRECT
	//
	//===============================================================================//

	hscr_add_card_entry("BIOBOLT","VIRIDIAN");
	hscr_add_card_entry("BIOSTORM","VIRIDIAN");
	hscr_add_card_entry("BRAMBLE_ERUPTION","VIRIDIAN");
	hscr_add_card_entry("CLAW","VIRIDIAN");
	hscr_add_card_entry("FELL","VIRIDIAN");
	hscr_add_card_entry("FERAL_FRENZY","VIRIDIAN");
	hscr_add_card_entry("HUNTERS_JAVELIN","VIRIDIAN");
	hscr_add_card_entry("NATURES_FURY","VIRIDIAN");
	hscr_add_card_entry("PRIMAL_BLAST","VIRIDIAN");
	hscr_add_card_entry("SAVAGE_MAUL","VIRIDIAN");
	hscr_add_card_entry("SPIKE_PIERCE","VIRIDIAN");
	hscr_add_card_entry("SPINESLING","VIRIDIAN");
	hscr_add_card_entry("SPIRIT_PIERCE","VIRIDIAN");
	hscr_add_card_entry("SPORE_CLOUD","VIRIDIAN");
	hscr_add_card_entry("STALKING_SWIPE","VIRIDIAN");
	hscr_add_card_entry("STAMPEDE","VIRIDIAN");
	hscr_add_card_entry("UNSEEN_ROOT","VIRIDIAN");
	hscr_add_card_entry("VERDANT_SWIPES","VIRIDIAN");
	hscr_add_card_entry("WILDSTRIKE","VIRIDIAN");


	//===============================================================================//
	//
	// ATTACK - DIRECT SPECIALTY
	//
	//===============================================================================//

	hscr_add_card_entry("BEASTIAL_WRATH","VIRIDIAN");
	hscr_add_card_entry("GREENFLOW","VIRIDIAN");
	hscr_add_card_entry("HUNTERS_INSTINCT","VIRIDIAN");
	hscr_add_card_entry("NATURES_WRATH","VIRIDIAN");
	hscr_add_card_entry("OLD_GROWTH_PUMMEL","VIRIDIAN");
	hscr_add_card_entry("ROT_BLOOM","VIRIDIAN");
	hscr_add_card_entry("SEED_BARRAGE","VIRIDIAN");
	hscr_add_card_entry("SNARLING_BITE","VIRIDIAN");
	hscr_add_card_entry("THORN_STORM","VIRIDIAN");
	hscr_add_card_entry("TOXIC_ERUPTION","VIRIDIAN");
	hscr_add_card_entry("VERDANT_BOLT","VIRIDIAN");
	hscr_add_card_entry("VIRIDIAN_BURST","VIRIDIAN");


	//===============================================================================//
	//
	// ATTACK - DOT
	//
	//===============================================================================//

	hscr_add_card_entry("BLOWDART","VIRIDIAN");
	hscr_add_card_entry("POTENT_SPORE","VIRIDIAN");
	hscr_add_card_entry("RAKE","VIRIDIAN");
	hscr_add_card_entry("SPIRIT_FANG","VIRIDIAN");
	hscr_add_card_entry("SPIT_VENOM","VIRIDIAN");
	hscr_add_card_entry("VIRAL_SURGE","VIRIDIAN");


	//===============================================================================//
	//
	// DEFENSE
	//
	//===============================================================================//

	hscr_add_card_entry("BARKSKIN","VIRIDIAN");
	hscr_add_card_entry("BLOOMING_SHIELD","VIRIDIAN");
	hscr_add_card_entry("INTERLOCKING_SCALES","VIRIDIAN");
	hscr_add_card_entry("NATURAL_RECOVERY","VIRIDIAN");
	hscr_add_card_entry("NATURES_GRACE","VIRIDIAN");
	hscr_add_card_entry("OVERGROWTH","VIRIDIAN");
	hscr_add_card_entry("REGENERATE","VIRIDIAN");
	hscr_add_card_entry("ROOTED_DEFENSE","VIRIDIAN");
	hscr_add_card_entry("SECOND_BLOOM","VIRIDIAN");
	hscr_add_card_entry("SINEWY_VINES","VIRIDIAN");
	hscr_add_card_entry("STEELFUR","VIRIDIAN");
	hscr_add_card_entry("SYMBIOSIS","VIRIDIAN");
	hscr_add_card_entry("THICK_HIDE","VIRIDIAN");
	hscr_add_card_entry("THORNMAIL","VIRIDIAN");
	hscr_add_card_entry("WILDWARD","VIRIDIAN");


	//===============================================================================//
	//
	// UTILITY
	//
	//===============================================================================//

	hscr_add_card_entry("BLOOMING_SPRITE","VIRIDIAN");
	hscr_add_card_entry("BLOOMTIDE","VIRIDIAN");
	hscr_add_card_entry("DISTRACTING_TRAP","VIRIDIAN");
	hscr_add_card_entry("DORMANT_SEED","VIRIDIAN");
	hscr_add_card_entry("EMERALD_WISDOM","VIRIDIAN");
	hscr_add_card_entry("FUNGAL_RECYCLING","VIRIDIAN");
	hscr_add_card_entry("GERMINATE","VIRIDIAN");
	hscr_add_card_entry("GREENSTEP","VIRIDIAN");
	hscr_add_card_entry("GROWTH_SIGIL","VIRIDIAN");
	hscr_add_card_entry("LIFE_SPIRIT","VIRIDIAN");
	hscr_add_card_entry("MANAVINE","VIRIDIAN");
	hscr_add_card_entry("NATURAL_CYCLE","VIRIDIAN");
	hscr_add_card_entry("PHEROMONES","VIRIDIAN");
	hscr_add_card_entry("RETURN_TO_NATURE","VIRIDIAN");
	hscr_add_card_entry("ROTTING_SPORES","VIRIDIAN");
	hscr_add_card_entry("SEED_THE_FIELD","VIRIDIAN");
	hscr_add_card_entry("SERPENT_SUMMON","VIRIDIAN");
	hscr_add_card_entry("THORN_NET","VIRIDIAN");
	hscr_add_card_entry("TOXIC_SNARE","VIRIDIAN");
	hscr_add_card_entry("TRANQUILITY","VIRIDIAN");
	hscr_add_card_entry("VENOM_BLOOM","VIRIDIAN");


	//===============================================================================//
	//
	// SUPPORT
	//
	//===============================================================================//

	hscr_add_card_entry("BRAMBLE_HIDE","VIRIDIAN");
	hscr_add_card_entry("BURGEONING_BLOOM","VIRIDIAN");
	hscr_add_card_entry("BURSTING_SEED","VIRIDIAN");
	hscr_add_card_entry("CRIPPLING_VINES","VIRIDIAN");
	hscr_add_card_entry("CULTIVATE","VIRIDIAN");
	hscr_add_card_entry("CURE_ALL","VIRIDIAN");
	hscr_add_card_entry("DECAYING_TOUCH","VIRIDIAN");
	hscr_add_card_entry("DISEASE","VIRIDIAN");
	hscr_add_card_entry("DRAINING_KISS","VIRIDIAN");
	hscr_add_card_entry("EMERALD_SLAM","VIRIDIAN");
	hscr_add_card_entry("ENTANGLE","VIRIDIAN");
	hscr_add_card_entry("HONEYED_SCENT","VIRIDIAN");
	hscr_add_card_entry("LIFEBLOOM","VIRIDIAN");
	hscr_add_card_entry("MIRACLE_MUSA","VIRIDIAN");
	hscr_add_card_entry("NATURES_BOND","VIRIDIAN");
	hscr_add_card_entry("NATURES_MEND","VIRIDIAN");
	hscr_add_card_entry("PACK_INSTINCT","VIRIDIAN");
	hscr_add_card_entry("POLLINATE","VIRIDIAN");
	hscr_add_card_entry("POTENT_FRUIT","VIRIDIAN");
	hscr_add_card_entry("PREDATORS_MARK","VIRIDIAN");
	hscr_add_card_entry("PREDATORY_SCENT","VIRIDIAN");
	hscr_add_card_entry("REJUVENATE","VIRIDIAN");
	hscr_add_card_entry("SAPSPRING","VIRIDIAN");
	hscr_add_card_entry("SHIMMERING_SPORES","VIRIDIAN");
	hscr_add_card_entry("SLEEP_DART","VIRIDIAN");
	hscr_add_card_entry("SLEEPING_POLLEN","VIRIDIAN");
	hscr_add_card_entry("TOXIC_HIDE","VIRIDIAN");
	hscr_add_card_entry("VERDANT_EMBRACE","VIRIDIAN");
	hscr_add_card_entry("VERDANT_INSIGHT","VIRIDIAN");
	hscr_add_card_entry("WILD_VIGOR","VIRIDIAN");
	hscr_add_card_entry("WILT","VIRIDIAN");


	//===============================================================================//
	//
	// ARCHETYPE
	//
	//===============================================================================//

	hscr_add_card_entry("ANCIENT_GROVE","VIRIDIAN");
	hscr_add_card_entry("APEX_PREDATOR","VIRIDIAN");
	hscr_add_card_entry("CHANNEL_THE_SPIRITS","VIRIDIAN");
	hscr_add_card_entry("CIRCLE_OF_LIFE","VIRIDIAN");
	hscr_add_card_entry("ENDLESS_BLOOM","VIRIDIAN");
	hscr_add_card_entry("FOR_THE_THROAT","VIRIDIAN");
	hscr_add_card_entry("HEART_OF_THE_FOREST","VIRIDIAN");
	hscr_add_card_entry("PLAGUE_GARDEN","VIRIDIAN");
	hscr_add_card_entry("PROLIFERATE","VIRIDIAN");


	#endregion

	//===============================================================================//
	//
	// CERULEAN
	//
	//===============================================================================//
	#region CERULEAN


	//===============================================================================//
	//
	// ATTACK - DIRECT
	//
	//===============================================================================//
	hscr_add_card_entry("HAILSTONES","CERULEAN");
	hscr_add_card_entry("AVALANCHE_STRIKE","CERULEAN");
	hscr_add_card_entry("ICE_LANCE","CERULEAN");
	hscr_add_card_entry("TORRENT","CERULEAN");
	hscr_add_card_entry("BURST","CERULEAN");
	hscr_add_card_entry("TIDAL_SLASH","CERULEAN");
	hscr_add_card_entry("GLACIAL_CRUSH","CERULEAN");
	hscr_add_card_entry("RAZOR_FIN","CERULEAN");
	hscr_add_card_entry("ABYSSAL_TOUCH","CERULEAN");
	hscr_add_card_entry("DEEP_CURRENT","CERULEAN");
	hscr_add_card_entry("FROZEN_FANG","CERULEAN");
	hscr_add_card_entry("FROSTBOLT","CERULEAN");
	hscr_add_card_entry("CHILLING_WORD","CERULEAN");
	hscr_add_card_entry("FROZEN_SPEAR","CERULEAN");
	hscr_add_card_entry("ARCTIC_VOLLEY","CERULEAN");
	hscr_add_card_entry("CRASHING_WAVE","CERULEAN");
	hscr_add_card_entry("WHITEWATER","CERULEAN");
	
	
	//===============================================================================//
	//
	// ATTACK - SPECIALITY
	//
	//===============================================================================//
	hscr_add_card_entry("SHATTER_STRIKE","CERULEAN");
	hscr_add_card_entry("PRESSURE_SPIKE","CERULEAN");
	hscr_add_card_entry("COLD_SNAP","CERULEAN");
	hscr_add_card_entry("TIDAL_BREAK","CERULEAN");
	hscr_add_card_entry("DEPTH_CHARGE","CERULEAN");
	hscr_add_card_entry("WINTERS_BITE","CERULEAN");
	hscr_add_card_entry("WINTER_RESONANCE","CERULEAN");
	hscr_add_card_entry("ABSOLUTE_ZERO","CERULEAN");
	hscr_add_card_entry("BITTER_CHILL","CERULEAN");
	hscr_add_card_entry("PRESSURE_CRUSH","CERULEAN");
	hscr_add_card_entry("KRAKENSLAM","CERULEAN");
	hscr_add_card_entry("FROSTBURN_NOVA","CERULEAN");
	hscr_add_card_entry("GLACIAL_ERUPTION","CERULEAN");
	hscr_add_card_entry("FRACTURE","CERULEAN");

	//===============================================================================//
	//
	// DEFENSE
	//
	//===============================================================================//
	hscr_add_card_entry("SHELL_SHIELD","CERULEAN");
	hscr_add_card_entry("ICE_PLATING","CERULEAN");
	hscr_add_card_entry("FROZEN_BULWARK","CERULEAN");
	hscr_add_card_entry("SNOWFORT","CERULEAN");
	hscr_add_card_entry("SNOWDRIFT","CERULEAN");
	hscr_add_card_entry("ICE_ACCRETION","CERULEAN");
	hscr_add_card_entry("FROZEN_BASTION","CERULEAN");
	hscr_add_card_entry("BUBBLE","CERULEAN");
	hscr_add_card_entry("CRYSTAL_SHELL","CERULEAN");
	hscr_add_card_entry("FROZEN_ARMOR","CERULEAN");
	
	#endregion

	//----------------//
	//UPDATE REVISION//
	//----------------//
	global.ct_logbook_revision++;
}