//===============================================================================//
//
// SCRIPT: SCR_INIT_LOGBOOK_BEASTS
// FUNCTION: Initializes the beast logbook catalog.
//           Creates one persistent logbook entry for each known beast id.
//           Stores entries in both ordered list and lookup map.
//
//===============================================================================//

function scr_init_logbook_beasts(){

	//—------------------------------------------------------------------------------//
	// RESET EXISTING LOGBOOK DATA
	//—------------------------------------------------------------------------------//
	ds_list_clear(global.list_logbook_beasts);
	ds_map_clear(global.map_logbook_beasts);

	//—------------------------------------------------------------------------------//
	// LOCAL HELPER: ADD BEAST ENTRY
	//—------------------------------------------------------------------------------//
	function hscr_add_beast_entry(_str_beast_id,_str_color_group){

		var _stct_beast_info = scr_get_beast_info(_str_beast_id);
		var _flag_has_beast_info = (_stct_beast_info != undefined);

		var _stct_entry = {
			_str_beast_id : _str_beast_id,
			_str_beast_name : _str_beast_id,
			_str_color_group : _str_color_group,

			_stct_beast_info : _stct_beast_info,
			_flag_has_beast_info : _flag_has_beast_info,

			_flag_seen : false,
			_flag_captured : false,

			_ct_seen : 0,
			_ct_captured : 0
		};

		if (_flag_has_beast_info){
			_stct_entry._str_beast_name = _stct_beast_info._str_beast_name;
		}

		ds_list_add(global.list_logbook_beasts,_stct_entry);
		global.map_logbook_beasts[? _str_beast_id] = _stct_entry;
	}

	//—------------------------------------------------------------------------------//
	// VIRIDIAN
	//—------------------------------------------------------------------------------//
	#region VIRIDIAN
	hscr_add_beast_entry("ARBRAWN","VIRIDIAN");
	hscr_add_beast_entry("ARGENTBUD","VIRIDIAN");
	hscr_add_beast_entry("BEAVINE","VIRIDIAN");
	hscr_add_beast_entry("BRYOBITE","VIRIDIAN");
	hscr_add_beast_entry("CHITROOPER","VIRIDIAN");
	hscr_add_beast_entry("CRUSABER","VIRIDIAN");
	hscr_add_beast_entry("DRYADAE","VIRIDIAN");
	hscr_add_beast_entry("FIGHTREE","VIRIDIAN");
	hscr_add_beast_entry("FLITSAGE","VIRIDIAN");
	hscr_add_beast_entry("FURN","VIRIDIAN");
	hscr_add_beast_entry("LEPOROOT","VIRIDIAN");
	hscr_add_beast_entry("LUMBUCK","VIRIDIAN");
	hscr_add_beast_entry("MAMBARK","VIRIDIAN");
	hscr_add_beast_entry("MORELUSH","VIRIDIAN");
	hscr_add_beast_entry("SPOROSE","VIRIDIAN");
	hscr_add_beast_entry("STRIGIBLOOM","VIRIDIAN");
	hscr_add_beast_entry("TURFRANTULA","VIRIDIAN");
	#endregion

	//—------------------------------------------------------------------------------//
	// CERULEAN
	//—------------------------------------------------------------------------------//
	#region CERULEAN
	hscr_add_beast_entry("AMMOMARSH","CERULEAN");
	hscr_add_beast_entry("BLIZZDRIFT","CERULEAN");
	hscr_add_beast_entry("CAUDAQUA","CERULEAN");
	hscr_add_beast_entry("CEPHARIME","CERULEAN");
	hscr_add_beast_entry("CHELONSEA","CERULEAN");
	hscr_add_beast_entry("CORALLIARC","CERULEAN");
	hscr_add_beast_entry("FROSTUSK","CERULEAN");
	hscr_add_beast_entry("GALENATRIUM","CERULEAN");
	hscr_add_beast_entry("GLACIMIGHT","CERULEAN");
	hscr_add_beast_entry("GULFLOW","CERULEAN");
	hscr_add_beast_entry("ISTIRAIN","CERULEAN");
	hscr_add_beast_entry("KELPLATANI","CERULEAN");
	hscr_add_beast_entry("LONTRIVER","CERULEAN");
	hscr_add_beast_entry("MARITIMICE","CERULEAN");
	hscr_add_beast_entry("SALTWAGG","CERULEAN");
	hscr_add_beast_entry("SPHENISKIP","CERULEAN");
	#endregion

	//—------------------------------------------------------------------------------//
	// VERMILION
	//—------------------------------------------------------------------------------//
	#region VERMILION
	hscr_add_beast_entry("ASCHEMASS","VERMILION");
	hscr_add_beast_entry("CANIGNIS","VERMILION");
	hscr_add_beast_entry("DAIMONIS","VERMILION");
	hscr_add_beast_entry("DRAKOAL","VERMILION");
	hscr_add_beast_entry("EMBEROOST","VERMILION");
	hscr_add_beast_entry("HELLSHROOM","VERMILION");
	hscr_add_beast_entry("IMPARCH","VERMILION");
	hscr_add_beast_entry("INFERNUS","VERMILION");
	hscr_add_beast_entry("LAVAROWANA","VERMILION");
	hscr_add_beast_entry("PYREKNIGHT","VERMILION");
	hscr_add_beast_entry("PYROPLUME","VERMILION");
	hscr_add_beast_entry("SANGUINAUT","VERMILION");
	hscr_add_beast_entry("SLAGOLEM","VERMILION");
	hscr_add_beast_entry("SOLEMOLD","VERMILION");
	hscr_add_beast_entry("WRATHOOD","VERMILION");
	hscr_add_beast_entry("WYRMELTA","VERMILION");
	#endregion

	global.ct_logbook_revision++;
}