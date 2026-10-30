//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REWARD_ROLL_PREMIUM_ITEM
// FUNCTION: Awards one premium World Event Item.
//
//           CATEGORY WEIGHTS:
//           - Held Item: 50%
//           - Prism:     30%
//           - Egg:       20%
//
//           HELD QUALITY: II 50%, III 30%, IV 20%.
//           PRISM QUALITY: Rare 50%, Epic 30%, Legendary 20%.
//           Arcwork Prisms are never rolled.
//
// ARGUMENTS: _stct_world_event - Completed World Event struct.
// RETURNS: SCR_REWARD_AWARD_INVENTORY_ITEM result struct, or undefined.
//
//===============================================================================//

function scr_world_event_reward_roll_premium_item(_stct_world_event){

	if (!is_struct(_stct_world_event)){
		return undefined;
	}

	var _stct_config =
		scr_world_event_reward_get_config(
			_stct_world_event._str_event_id
		);

	var _stct_category_weights =
		_stct_config._stct_item_category_weights;

	var _val_held = max(0,_stct_category_weights._val_held);
	var _val_prism = max(0,_stct_category_weights._val_prism);
	var _val_egg = max(0,_stct_category_weights._val_egg);

	var _val_total =
		_val_held +
		_val_prism +
		_val_egg;

	if (_val_total <= 0){
		return undefined;
	}

	var _val_roll = random(_val_total);
	var _str_category = "HELD";

	if (_val_roll < _val_held){
		_str_category = "HELD";
	}
	else{
		_val_roll -= _val_held;

		if (_val_roll < _val_prism){
			_str_category = "PRISM";
		}
		else{
			_str_category = "EGG";
		}
	}

	var _str_item_id = "";
	var _str_quality = "";

	//================//
	//HELD ITEM//
	//================//
	if (_str_category == "HELD"){

		var _str_tier =
			scr_world_event_reward_roll_tier(
				_stct_config._stct_held_tier_weights
			);

		var _arr_tier_fallback = [];

		switch (_str_tier){
			case "IV":
				_arr_tier_fallback = ["IV","III","II"];
			break;

			case "III":
				_arr_tier_fallback = ["III","II","IV"];
			break;

			case "II":
			default:
				_arr_tier_fallback = ["II","III","IV"];
			break;
		}

		for (
			var _it_tier = 0;
			_it_tier < array_length(_arr_tier_fallback);
			_it_tier++
		){

			var _str_try_tier =
				_arr_tier_fallback[_it_tier];

			var _arr_held_pool =
				scr_world_event_reward_get_held_pool(
					_str_try_tier
				);

			if (
				!is_array(_arr_held_pool) ||
				array_length(_arr_held_pool) <= 0
			){
				continue;
			}

			_str_item_id =
				_arr_held_pool[
					irandom(
						array_length(_arr_held_pool) - 1
					)
				];

			_str_quality =
				_str_try_tier;

			break;
		}
	}

	//================//
	//PRISM//
	//================//
	else if (_str_category == "PRISM"){

		var _str_tier =
			scr_world_event_reward_roll_tier(
				_stct_config._stct_prism_tier_weights
			);

		switch (_str_tier){
			case "IV":
				_str_item_id = "PRISM_LEGENDARY";
				_str_quality = "LEGENDARY";
			break;

			case "III":
				_str_item_id = "PRISM_EPIC";
				_str_quality = "EPIC";
			break;

			case "II":
			default:
				_str_item_id = "PRISM_RARE";
				_str_quality = "RARE";
			break;
		}
	}

	//================//
	//EGG//
	//================//
	else{

		var _arr_egg_pool =
			scr_world_event_reward_get_egg_pool();

		// Migration first attempts to award the Migration species Egg.
		if (
			_stct_world_event._str_event_id == "MIGRATION" &&
			is_struct(_stct_world_event._stct_payload) &&
			variable_struct_exists(
				_stct_world_event._stct_payload,
				"_str_migration_species"
			)
		){

			var _str_migration_egg =
				"EGG_" +
				string_upper(
					string(
						_stct_world_event
							._stct_payload
							._str_migration_species
					)
				);

			if (array_contains(_arr_egg_pool,_str_migration_egg)){
				_str_item_id =
					_str_migration_egg;
			}
		}

		if (
			_str_item_id == "" &&
			array_length(_arr_egg_pool) > 0
		){
			_str_item_id =
				_arr_egg_pool[
					irandom(
						array_length(_arr_egg_pool) - 1
					)
				];
		}

		_str_quality = "EGG";
	}

	if (_str_item_id == ""){
		return undefined;
	}

	var _stct_award =
		scr_reward_award_inventory_item(
			_str_item_id,
			"WORLD_EVENT",
			_stct_world_event._str_event_id
		);

	if (is_struct(_stct_award)){
		_stct_award._str_premium_category = _str_category;
		_stct_award._str_premium_quality = _str_quality;
	}

	return _stct_award;
}
