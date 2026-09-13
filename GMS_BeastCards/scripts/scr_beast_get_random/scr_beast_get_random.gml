//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_RANDOM
// FUNCTION: Performs a weighted roll from a supplied Beast pool.
//           Uses stat-total rarity weights.
//           Returns a newly initialized randomized Beast.
//
// ARGUMENTS: _arr_beast_pool is an array of Beast names eligible for the roll.
// RETURNS: A newly initialized random Beast, or undefined if no valid Beast
//          can be selected.
//
//===============================================================================//

function scr_beast_get_random(_arr_beast_pool){

	//=====================//
	//VALIDATE BEAST POOL//
	//=====================//
	if (!is_array(_arr_beast_pool)){
		return undefined;
	}

	var _ct_beasts = array_length(_arr_beast_pool);

	if (_ct_beasts <= 0){
		return undefined;
	}

	//================//
	//BEAST WEIGHTS//
	//================//
	static _stct_beast_weights = {

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

	//========================//
	//CALCULATE TOTAL WEIGHT//
	//========================//
	var _val_total_weight = 0;

	for (var _it_beast = 0;_it_beast < _ct_beasts;_it_beast++){

		var _str_beast_name = _arr_beast_pool[_it_beast];

		if (!variable_struct_exists(_stct_beast_weights,_str_beast_name)){
			continue;
		}

		_val_total_weight += variable_struct_get(_stct_beast_weights,_str_beast_name);
	}

	if (_val_total_weight <= 0){
		return undefined;
	}

	//================//
	//ROLL BEAST//
	//================//
	var _val_roll = random(_val_total_weight);
	var _val_running_weight = 0;

	for (var _it_beast = 0;_it_beast < _ct_beasts;_it_beast++){

		var _str_beast_name = _arr_beast_pool[_it_beast];

		if (!variable_struct_exists(_stct_beast_weights,_str_beast_name)){
			continue;
		}

		var _val_beast_weight = variable_struct_get(_stct_beast_weights,_str_beast_name);
		_val_running_weight += _val_beast_weight;

		if (_val_roll < _val_running_weight){
			return scr_beast_init_random(_str_beast_name);
		}
	}

	return undefined;
}