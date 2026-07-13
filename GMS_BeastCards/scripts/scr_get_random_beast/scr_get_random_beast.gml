//===============================================================================//
//
// SCRIPT: SCR_GET_RANDOM_BEAST
// FUNCTION: Performs a weighted roll from a supplied beast pool.
//           Uses stat-total rarity weights.
//           Returns a newly initialized randomized beast.
//
//===============================================================================//

function scr_get_random_beast(_arr_beast_pool){

	var _stct_weights = {

		#region VIRIDIAN
		ARBRAWN      : 1,
		ARGENTBUD    : 20,
		BEAVINE      : 20,
		BRYOBITE     : 5,
		CHITROOPER   : 20,
		CRUSABER     : 5,
		DRYADAE      : 10,
		FIGHTREE     : 1,
		FLITSAGE     : 20,
		FURN         : 20,
		LEPOROOT     : 20,
		LUMBUCK      : 5,
		MAMBARK      : 20,
		MORELUSH     : 20,
		SPOROSE      : 10,
		STRIGIBLOOM  : 10,
		TURFRANTULA  : 20,
		#endregion

		#region CERULEAN
		AMMOMARSH    : 5,
		BLIZZDRIFT   : 10,
		CAUDAQUA     : 20,
		CEPHARIME    : 10,
		CHELONSEA    : 5,
		CORALLIARC   : 10,
		FROSTUSK     : 5,
		GALENATRIUM  : 20,
		GLACIMIGHT   : 1,
		GULFLOW      : 10,
		ISTIRAIN     : 10,
		KELPLATANI   : 5,
		LONTRIVER    : 5,
		MARITIMICE   : 5,
		SALTWAGG     : 10,
		SPHENISKIP   : 10,
		#endregion

		#region VERMILION
		ASCHEMASS    : 20,
		CANIGNIS     : 20,
		DAIMONIS     : 10,
		DRAKOAL      : 20,
		EMBEROOST    : 5,
		HELLSHROOM   : 10,
		IMPARCH      : 20,
		INFERNUS     : 1,
		LAVAROWANA   : 20,
		PYREKNIGHT   : 1,
		PYROPLUME    : 10,
		SANGUINAUT   : 10,
		SLAGOLEM     : 10,
		SOLEMOLD     : 20,
		WRATHOOD     : 20,
		WYRMELTA     : 5
		#endregion
	};

	var _val_total_weight = 0;

	//-----------------------//
	// CALCULATE TOTAL WEIGHT //
	//-----------------------//
	for (var _it_beast = 0; _it_beast < array_length(_arr_beast_pool); _it_beast++){

		var _str_beast_name = _arr_beast_pool[_it_beast];

		if (variable_struct_exists(_stct_weights,_str_beast_name)){
			_val_total_weight += variable_struct_get(_stct_weights,_str_beast_name);
		}
	}

	if (_val_total_weight <= 0){
		show_debug_message("BEAST ERROR: Random beast pool has no valid weighted beasts.");
		return undefined;
	}

	//------//
	// ROLL //
	//------//
	var _val_roll = random(_val_total_weight);

	//--------------//
	// RESOLVE ROLL //
	//--------------//
	var _val_running_weight = 0;
	var _str_selected_beast = "";

	for (var _it_beast = 0; _it_beast < array_length(_arr_beast_pool); _it_beast++){

		var _str_beast_name = _arr_beast_pool[_it_beast];

		if (variable_struct_exists(_stct_weights,_str_beast_name)){

			_val_running_weight += variable_struct_get(_stct_weights,_str_beast_name);

			if (_val_roll < _val_running_weight){
				_str_selected_beast = _str_beast_name;
				break;
			}
		}
	}

	if (_str_selected_beast == ""){
		show_debug_message("BEAST ERROR: Random beast roll failed to select a beast.");
		return undefined;
	}

	return scr_init_beast_random(_str_selected_beast);
}