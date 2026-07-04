//===============================================================================//
//
// SCRIPT: SCR_GET_RANDOM_ITEM
// FUNCTION: Rolls a weighted random item id from the supplied item pool.
//           Uses local item weights to bias common and rare item results.
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
		EGG_ARBRAWN : 10,
		EGG_ARGENTBUD : 10,
		EGG_BEAVINE : 10,
		EGG_BRYOBITE : 10,
		EGG_CHITROOPER : 10,
		EGG_CRUSABER : 10,
		EGG_DRYADAE : 10,
		EGG_FIGHTREE : 10,
		EGG_FLITSAGE : 10,
		EGG_FURN : 10,
		EGG_LEPOROOT : 10,
		EGG_LUMBUCK : 10,
		EGG_MAMBARK : 10,
		EGG_MORELUSH : 10,
		EGG_SPOROSE : 10,
		EGG_STRIGIBLOOM : 10,
		EGG_TURFRANTULA : 10,
		#endregion

		#region CERULEAN
		EGG_AMMOMARSH : 10,
		EGG_BLIZZDRIFT : 10,
		EGG_CAUDAQUA : 10,
		EGG_CEPHARIME : 10,
		EGG_CHELONSEA : 10,
		EGG_CORALLIARC : 10,
		EGG_FROSTUSK : 10,
		EGG_GALENATRIUM : 10,
		EGG_GLACIMIGHT : 10,
		EGG_GULFLOW : 10,
		EGG_ISTIRAIN : 10,
		EGG_KELPLATANI : 10,
		EGG_LONTRIVER : 10,
		EGG_MARITIMICE : 10,
		EGG_SALTWAGG : 10,
		EGG_SPHENISKIP : 10,
		#endregion

		#region VERMILION
		EGG_ASCHEMASS : 10,
		EGG_CANIGNIS : 10,
		EGG_DAIMONIS : 10,
		EGG_DRAKOAL : 10,
		EGG_EMBEROOST : 10,
		EGG_HELLSHROOM : 10,
		EGG_IMPARCH : 10,
		EGG_INFERNUS : 10,
		EGG_LAVAROWANA : 10,
		EGG_PYREKNIGHT : 10,
		EGG_PYROPLUME : 10,
		EGG_SANGUINAUT : 10,
		EGG_SLAGOLEM : 10,
		EGG_SOLEMOLD : 10,
		EGG_WRATHOOD : 10,
		EGG_WYRMELTA : 10
		#endregion
	};
	var _val_total_weight = 0;

	for (var _it_item = 0; _it_item < ds_list_size(_list_pool); _it_item++){
		var _str_item_id = ds_list_find_value(_list_pool,_it_item);

		if (variable_struct_exists(_stct_weights,_str_item_id)){
			_val_total_weight += variable_struct_get(_stct_weights,_str_item_id);
		}
	}

	var _val_roll = irandom_range(1,_val_total_weight);
	var _val_running_weight = 0;
	var _str_return_item_id = "";

	for (var _it_item = 0; _it_item < ds_list_size(_list_pool); _it_item++){
		var _str_item_id = ds_list_find_value(_list_pool,_it_item);

		if (variable_struct_exists(_stct_weights,_str_item_id)){
			_val_running_weight += variable_struct_get(_stct_weights,_str_item_id);

			if (_val_roll <= _val_running_weight){
				_str_return_item_id = _str_item_id;
				break;
			}
		}
	}

	return _str_return_item_id;
}