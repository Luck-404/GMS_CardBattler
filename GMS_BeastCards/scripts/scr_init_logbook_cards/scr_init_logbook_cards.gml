//===============================================================================//
//
// SCRIPT: SCR_INIT_LOGBOOK_CARDS
// FUNCTION: Initializes the card logbook catalog.
//           Creates one persistent logbook entry for each known card id.
//           Stores entries in both ordered list and lookup map.
//
//===============================================================================//

function scr_init_logbook_cards(){

	//—------------------------------------------------------------------------------//
	// RESET EXISTING LOGBOOK DATA
	//—------------------------------------------------------------------------------//
	ds_list_clear(global.list_logbook_cards);
	ds_map_clear(global.map_logbook_cards);

	//—------------------------------------------------------------------------------//
	// LOCAL HELPER: ADD CARD ENTRY
	//—------------------------------------------------------------------------------//
	function hscr_add_card_entry(_str_card_id,_str_color_group){

		var _stct_card_info = scr_get_card_info(_str_card_id);
		var _flag_has_card_info = (_stct_card_info != undefined);

		var _stct_entry = {
			_str_card_id : _str_card_id,
			_str_card_name : _str_card_id,
			_str_color_group : _str_color_group,

			_stct_card_info : _stct_card_info,
			_flag_has_card_info : _flag_has_card_info,

			_flag_seen : false,
			_flag_obtained : false,

			_ct_seen : 0,
			_ct_obtained : 0
		};

		if (_flag_has_card_info){
			_stct_entry._str_card_name = _stct_card_info._str_card_name;
		}

		ds_list_add(global.list_logbook_cards,_stct_entry);
		global.map_logbook_cards[? _str_card_id] = _stct_entry;
	}

	//—------------------------------------------------------------------------------//
	// UNCOLORED
	//—------------------------------------------------------------------------------//
	#region UNCOLORED
	hscr_add_card_entry("HIDDEN_CARD","UNCOLORED");
	hscr_add_card_entry("STRIKE","UNCOLORED");
	hscr_add_card_entry("POWER_STRIKE","UNCOLORED");
	hscr_add_card_entry("BLOCK","UNCOLORED");
	hscr_add_card_entry("BULWARK","UNCOLORED");
	hscr_add_card_entry("INSPIRATION","UNCOLORED");
	hscr_add_card_entry("ECHO","UNCOLORED");
	hscr_add_card_entry("DEFT_STRIKE","UNCOLORED");
	hscr_add_card_entry("REPOSITION","UNCOLORED");
	hscr_add_card_entry("CLEARCAST","UNCOLORED");
	hscr_add_card_entry("RAPID_STRIKES","UNCOLORED");
	#endregion

	//—------------------------------------------------------------------------------//
	// VIRIDIAN
	//—------------------------------------------------------------------------------//
	#region VIRIDIAN
	hscr_add_card_entry("LIFE_SPIRIT","VIRIDIAN");
	hscr_add_card_entry("MIRACLE_MUSA","VIRIDIAN");
	hscr_add_card_entry("DISEASE","VIRIDIAN");
	hscr_add_card_entry("EMERALD_SLAM","VIRIDIAN");
	hscr_add_card_entry("GROWTH_SIGIL","VIRIDIAN");
	hscr_add_card_entry("EMERALD_WISDOM","VIRIDIAN");
	#endregion

	global.ct_logbook_revision++;
}