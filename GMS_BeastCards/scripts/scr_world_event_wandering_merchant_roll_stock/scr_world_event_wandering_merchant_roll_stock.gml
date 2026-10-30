//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_WANDERING_MERCHANT_ROLL_STOCK
// FUNCTION: Builds one finite special stock list for the Wandering Merchant.
//           Rolls 4-12 unique offers from the premium Held Item, Egg, and Prism
//           pools. The resulting list is persisted by World Event generation.
//
// RETURNS: NPC trade-stock definition array.
//
//===============================================================================//

function scr_world_event_wandering_merchant_roll_stock(){

	//================//
	//CANDIDATE POOLS//
	//================//
	var _arr_held_ii =
		scr_world_event_reward_get_held_pool(
			"II"
		);

	var _arr_held_iii =
		scr_world_event_reward_get_held_pool(
			"III"
		);

	var _arr_held_iv =
		scr_world_event_reward_get_held_pool(
			"IV"
		);

	var _arr_eggs =
		scr_world_event_reward_get_egg_pool();

	var _list_candidates =
		ds_list_create();

	//================//
	//HELD ITEMS II//
	//================//
	for (
		var _it_item = 0;
		_it_item < array_length(_arr_held_ii);
		_it_item++
	){

		ds_list_add(
			_list_candidates,
			{
				_str_item_id : _arr_held_ii[_it_item],
				_val_gold_cost : 300,
				_ct_stock : 1,
				_flag_infinite : false
			}
		);
	}

	//================//
	//HELD ITEMS III//
	//================//
	for (
		var _it_item = 0;
		_it_item < array_length(_arr_held_iii);
		_it_item++
	){

		ds_list_add(
			_list_candidates,
			{
				_str_item_id : _arr_held_iii[_it_item],
				_val_gold_cost : 600,
				_ct_stock : 1,
				_flag_infinite : false
			}
		);
	}

	//================//
	//HELD ITEMS IV//
	//================//
	for (
		var _it_item = 0;
		_it_item < array_length(_arr_held_iv);
		_it_item++
	){

		ds_list_add(
			_list_candidates,
			{
				_str_item_id : _arr_held_iv[_it_item],
				_val_gold_cost : 1000,
				_ct_stock : 1,
				_flag_infinite : false
			}
		);
	}

	//================//
	//BEAST EGGS//
	//================//
	for (
		var _it_item = 0;
		_it_item < array_length(_arr_eggs);
		_it_item++
	){

		ds_list_add(
			_list_candidates,
			{
				_str_item_id : _arr_eggs[_it_item],
				_val_gold_cost : 750,
				_ct_stock : 1,
				_flag_infinite : false
			}
		);
	}

	//================//
	//PRISMS//
	//================//
	ds_list_add(
		_list_candidates,
		{
			_str_item_id : "PRISM_RARE",
			_val_gold_cost : 350,
			_ct_stock : 3,
			_flag_infinite : false
		}
	);

	ds_list_add(
		_list_candidates,
		{
			_str_item_id : "PRISM_EPIC",
			_val_gold_cost : 800,
			_ct_stock : 1,
			_flag_infinite : false
		}
	);

	//================//
	//VALIDATE POOL//
	//================//
	var _ct_candidates =
		ds_list_size(
			_list_candidates
		);

	if (_ct_candidates <= 0){

		ds_list_destroy(
			_list_candidates
		);

		return [];
	}

	//================//
	//ROLL OFFER COUNT//
	//================//
	var _ct_stock_target =
		irandom_range(
			4,
			12
		);

	_ct_stock_target =
		min(
			_ct_stock_target,
			_ct_candidates
		);

	//================//
	//RANDOMIZE POOL//
	//================//
	ds_list_shuffle(
		_list_candidates
	);

	//================//
	//BUILD STOCK//
	//================//
	var _arr_stock = [];

	for (
		var _it_offer = 0;
		_it_offer < _ct_stock_target;
		_it_offer++
	){

		array_push(
			_arr_stock,
			ds_list_find_value(
				_list_candidates,
				_it_offer
			)
		);
	}

	ds_list_destroy(
		_list_candidates
	);

	return _arr_stock;
}
