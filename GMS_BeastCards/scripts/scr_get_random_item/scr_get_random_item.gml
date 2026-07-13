//===============================================================================//
//
// SCRIPT: SCR_GET_RANDOM_ITEM
// FUNCTION: Rolls a weighted random item id from the supplied item pool.
//           Uses lower fractional weights for beast eggs.
//           Returns the selected item id string.
//
//===============================================================================//

function scr_get_random_item(_list_pool){

	var _stct_weights = {
		QUEST_IMPORTANT_NOTEBOOK : 5,
		HELD_POWERFUL_STONE : 10,
		CONSUMABLE_HEALING_SALVE : 50,
		PRISM_BASIC_PRISM : 50,

		#region VIRIDIAN
		EGG_ARBRAWN : 0.1,
		EGG_ARGENTBUD : 2,
		EGG_BEAVINE : 2,
		EGG_BRYOBITE : 0.5,
		EGG_CHITROOPER : 2,
		EGG_CRUSABER : 0.5,
		EGG_DRYADAE : 1,
		EGG_FIGHTREE : 0.1,
		EGG_FLITSAGE : 2,
		EGG_FURN : 2,
		EGG_LEPOROOT : 2,
		EGG_LUMBUCK : 0.5,
		EGG_MAMBARK : 2,
		EGG_MORELUSH : 2,
		EGG_SPOROSE : 1,
		EGG_STRIGIBLOOM : 1,
		EGG_TURFRANTULA : 2,
		#endregion

		#region CERULEAN
		EGG_AMMOMARSH : 0.5,
		EGG_BLIZZDRIFT : 1,
		EGG_CAUDAQUA : 2,
		EGG_CEPHARIME : 1,
		EGG_CHELONSEA : 0.5,
		EGG_CORALLIARC : 1,
		EGG_FROSTUSK : 0.5,
		EGG_GALENATRIUM : 2,
		EGG_GLACIMIGHT : 0.1,
		EGG_GULFLOW : 1,
		EGG_ISTIRAIN : 1,
		EGG_KELPLATANI : 0.5,
		EGG_LONTRIVER : 0.5,
		EGG_MARITIMICE : 0.5,
		EGG_SALTWAGG : 1,
		EGG_SPHENISKIP : 1,
		#endregion

		#region VERMILION
		EGG_ASCHEMASS : 2,
		EGG_CANIGNIS : 2,
		EGG_DAIMONIS : 1,
		EGG_DRAKOAL : 2,
		EGG_EMBEROOST : 0.5,
		EGG_HELLSHROOM : 1,
		EGG_IMPARCH : 2,
		EGG_INFERNUS : 0.1,
		EGG_LAVAROWANA : 2,
		EGG_PYREKNIGHT : 0.1,
		EGG_PYROPLUME : 1,
		EGG_SANGUINAUT : 1,
		EGG_SLAGOLEM : 1,
		EGG_SOLEMOLD : 2,
		EGG_WRATHOOD : 2,
		EGG_WYRMELTA : 0.5
		#endregion
	};

	var _val_total_weight = 0;

	//-----------------------//
	// CALCULATE TOTAL WEIGHT //
	//-----------------------//
	for (var _it_item = 0; _it_item < ds_list_size(_list_pool); _it_item++){

		var _str_item_id = ds_list_find_value(_list_pool,_it_item);

		if (variable_struct_exists(_stct_weights,_str_item_id)){
			_val_total_weight += variable_struct_get(_stct_weights,_str_item_id);
		}
	}

	if (_val_total_weight <= 0){
		show_debug_message("ITEM ERROR: Random item pool has no valid weighted items.");
		return "";
	}

	//------//
	// ROLL //
	//------//
	var _val_roll = random(_val_total_weight);

	//--------------//
	// RESOLVE ROLL //
	//--------------//
	var _val_running_weight = 0;
	var _str_return_item_id = "";

	for (var _it_item = 0; _it_item < ds_list_size(_list_pool); _it_item++){

		var _str_item_id = ds_list_find_value(_list_pool,_it_item);

		if (variable_struct_exists(_stct_weights,_str_item_id)){

			_val_running_weight += variable_struct_get(_stct_weights,_str_item_id);

			if (_val_roll < _val_running_weight){
				_str_return_item_id = _str_item_id;
				break;
			}
		}
	}

	if (_str_return_item_id == ""){
		show_debug_message("ITEM ERROR: Random item roll failed to select an item.");
	}

	return _str_return_item_id;
}