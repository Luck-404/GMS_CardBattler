//===============================================================================//
//
// SCRIPT: SCR_GET_RANDOM_BEAST
// FUNCTION: Performs a weighted roll from a supplied beast pool.
//           Returns a newly initialized randomized beast.
//
//===============================================================================//

function scr_get_random_beast(_arr_beast_pool){

	var _stct_weights = {
		ARBRAWN   : 5,
		ARGENTBUD : 20,
		BEAVINE   : 50,
		// BRYOBITE
		// CHITROOPER
		// CRUSABER
		// DRYADAE
		// FIGHTREE
		FLITSAGE  : 50,
		FURN      : 20
		// LEPOROOT
		// LUMBUCK
		// MAMBARK
		// MORELUSH
		// SPOROSE
		// STRIGIBLOOM
		// TURFRANTULA
		// AMMOMARSH
		// BLIZZDRIFT
		// CAUDAQUA
		// CEPHARIME
		// CHELONSEA
		// CORALLIARC
		// FROSTUSK
		// GALENATRIUM
		// GLACIMIGHT
		// GULFFLOW
		// ISTIRAIN
		// KELPLATANI
		// LONTRIVER
		// MARITIMICE
		// SALTWAGG
		// SPHENISKIP
		// ASCHEMASS
		// CANIGNIS
		// DAIMONIS
		// DRAKOAL
		// EMBEROOST
		// HELLSHROOM
		// IMPARCH
		// INFERNUS
		// LAVAROWANA
		// PYREKNIGHT
		// PYROPLUME
		// SANGUINAUT
		// SLAGOLEM
		// SOLEMOLD
		// WRATHOOD
		// WYRMELTA
	};

	var _val_total_weight = 0;

	// CALCULATE TOTAL WEIGHT
	for (var _it_beast = 0; _it_beast < array_length(_arr_beast_pool); _it_beast++){
		var _str_beast_name = _arr_beast_pool[_it_beast];

		if (variable_struct_exists(_stct_weights,_str_beast_name)){
			_val_total_weight += variable_struct_get(_stct_weights,_str_beast_name);
		}
	}

	// ROLL
	var _val_roll = irandom_range(1,_val_total_weight);

	// RESOLVE ROLL
	var _val_running_weight = 0;
	var _str_selected_beast = "";

	for (var _it_beast = 0; _it_beast < array_length(_arr_beast_pool); _it_beast++){
		var _str_beast_name = _arr_beast_pool[_it_beast];

		if (variable_struct_exists(_stct_weights,_str_beast_name)){
			_val_running_weight += variable_struct_get(_stct_weights,_str_beast_name);

			if (_val_roll <= _val_running_weight){
				_str_selected_beast = _str_beast_name;
				break;
			}
		}
	}

	return scr_init_beast_random(_str_selected_beast);
}