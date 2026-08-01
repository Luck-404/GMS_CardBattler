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
		var _stct_card_info =
			scr_get_card_info(_str_card_id);

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
		ds_list_add(
			global.list_logbook_cards,
			_stct_entry
		);

		global.map_logbook_cards[? _str_card_id] = _stct_entry;
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


	//----------------------//
	//EARLY / GENERAL CARDS//
	//----------------------//

	hscr_add_card_entry("LIFE_SPIRIT","VIRIDIAN");
	hscr_add_card_entry("MIRACLE_MUSA","VIRIDIAN");
	hscr_add_card_entry("DISEASE","VIRIDIAN");
	hscr_add_card_entry("EMERALD_SLAM","VIRIDIAN");
	hscr_add_card_entry("GROWTH_SIGIL","VIRIDIAN");
	hscr_add_card_entry("EMERALD_WISDOM","VIRIDIAN");


	//---------------//
	//ATTACK: DIRECT//
	//---------------//

	hscr_add_card_entry("CLAW","VIRIDIAN");
	hscr_add_card_entry("WILDSTRIKE","VIRIDIAN");

	hscr_add_card_entry("SPINESLING","VIRIDIAN");
	hscr_add_card_entry("BIOBOLT","VIRIDIAN");

	hscr_add_card_entry("VERDANT_BOLT","VIRIDIAN");

	hscr_add_card_entry("FELL","VIRIDIAN");
	hscr_add_card_entry("SPORE_CLOUD","VIRIDIAN");

	hscr_add_card_entry("STALKING_SWIPE","VIRIDIAN");
	hscr_add_card_entry("UNSEEN_ROOT","VIRIDIAN");

	hscr_add_card_entry("FERAL_FRENZY","VIRIDIAN");
	hscr_add_card_entry("VERDANT_SWIPES","VIRIDIAN");

	hscr_add_card_entry("BRAMBLE_ERUPTION","VIRIDIAN");

	hscr_add_card_entry("STAMPEDE","VIRIDIAN");
	hscr_add_card_entry("BIOSTORM","VIRIDIAN");

	hscr_add_card_entry("SPIKE_PIERCE","VIRIDIAN");
	hscr_add_card_entry("SPIRIT_PIERCE","VIRIDIAN");

	hscr_add_card_entry("SAVAGE_MAUL","VIRIDIAN");
	hscr_add_card_entry("NATURES_FURY","VIRIDIAN");

	hscr_add_card_entry("HUNTERS_JAVELIN","VIRIDIAN");
	hscr_add_card_entry("PRIMAL_BLAST","VIRIDIAN");

	hscr_add_card_entry("SNARLING_BITE","VIRIDIAN");

	hscr_add_card_entry("GREENFLOW","VIRIDIAN");
	hscr_add_card_entry("ROT_BLOOM","VIRIDIAN");
	hscr_add_card_entry("TOXIC_ERUPTION","VIRIDIAN");

	hscr_add_card_entry("HUNTERS_INSTINCT","VIRIDIAN");
	hscr_add_card_entry("NATURES_WRATH","VIRIDIAN");

	hscr_add_card_entry("SEED_BARRAGE","VIRIDIAN");

	hscr_add_card_entry("THORN_STORM","VIRIDIAN");
	hscr_add_card_entry("OLD_GROWTH_PUMMEL","VIRIDIAN");

	hscr_add_card_entry("VIRIDIAN_BURST","VIRIDIAN");
	hscr_add_card_entry("BEASTIAL_WRATH","VIRIDIAN");


	//------------//
	//ATTACK: DOT//
	//------------//

	hscr_add_card_entry("VIRAL_SURGE","VIRIDIAN");
	hscr_add_card_entry("POTENT_SPORE","VIRIDIAN");
	hscr_add_card_entry("BLOWDART","VIRIDIAN");
	hscr_add_card_entry("RAKE","VIRIDIAN");
	hscr_add_card_entry("SPIT_VENOM","VIRIDIAN");
	hscr_add_card_entry("SPIRIT_FANG","VIRIDIAN");


	//-------//
	//DEFENSE//
	//-------//

	hscr_add_card_entry("BARKSKIN","VIRIDIAN");
	hscr_add_card_entry("BLOOMING_SHIELD","VIRIDIAN");
	hscr_add_card_entry("OVERGROWTH","VIRIDIAN");
	hscr_add_card_entry("SYMBIOSIS","VIRIDIAN");


	#endregion


	//----------------//
	//UPDATE REVISION//
	//----------------//
	global.ct_logbook_revision++;
}