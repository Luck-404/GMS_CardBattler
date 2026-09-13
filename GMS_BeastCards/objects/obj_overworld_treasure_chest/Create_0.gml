//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_TREASURE_CHEST
// FUNCTION: Initializes treasure chest loot state and persistence.
//           Rolls random chest rarity when required.
//           Defines helpers for rarity, loot awards, proximity audio,
//           and structured reward logging.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
#region VARIABLES

//----------------//
//TREASURE STATE//
//----------------//
_ct_loot_rewards = 1;

_flag_triggered = false;

_str_rarity = "I";

_c_chest = c_white;

//----------------//
//AUDIO//
//----------------//
_val_nearby_sound_handle = -1;

#endregion

//================//
//INIT//
//================//
#region INIT

if (ds_map_exists(global.map_player_chests_opened,_uid_chest)){

	_flag_triggered = true;
	image_index = 1;
}
else if (_str_chest_id == "RANDOM"){

	hscr_overworld_treasure_roll_rarity();
}

#endregion

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_STOP_NEARBY_SOUND
// FUNCTION: Stops this chest's looping proximity sound if active.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_stop_nearby_sound = function(){

	if (_val_nearby_sound_handle == -1){
		return;
	}

	if (audio_is_playing(_val_nearby_sound_handle)){
		audio_stop_sound(_val_nearby_sound_handle);
	}

	_val_nearby_sound_handle = -1;
};

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_ROLL_RARITY
// FUNCTION: Rolls random chest rarity.
//           Updates chest color and number of random loot rewards.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_roll_rarity = function(){

	_str_rarity = choose(
		"I",
		"I",
		"I",
		"I",
		"I",
		"I",
		"II",
		"II",
		"II",
		"III"
	);

	switch (_str_rarity){

		case "I":

			_c_chest = c_white;
			_ct_loot_rewards = 3;

		break;

		case "II":

			_c_chest = c_lime;
			_ct_loot_rewards = 2;

		break;

		case "III":

			_c_chest = c_aqua;
			_ct_loot_rewards = 1;

		break;
	}
};

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_AWARD_CUSTOM_LOOT
// FUNCTION: Awards the configured loot assigned to this treasure chest.
//           Supports Cards, Inventory Items, and Gold.
//           Logs each reward actually granted.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_award_custom_loot = function(){

	var _arr_rewards = scr_overworld_treasure_get_custom_loot(
		_str_chest_id
	);

	if (!is_array(_arr_rewards)){
		return;
	}

	for (var _it_reward = 0;_it_reward < array_length(_arr_rewards);_it_reward++){

		var _stct_reward = _arr_rewards[_it_reward];

		if (!is_struct(_stct_reward)){
			continue;
		}

		var _str_reward_type = _stct_reward._str_type;
		var _str_reward_id = _stct_reward._str_reward_id;
		var _ct_reward_amount = _stct_reward._ct_amount;

		//================//
		//AWARD REWARD//
		//================//
		switch (_str_reward_type){

			//======//
			//CARD//
			//======//
			case "CARD":

				var _ct_cards_awarded = 0;

				for (var _it_card = 0;_it_card < _ct_reward_amount;_it_card++){

					var _stct_card = scr_card_get_info(
						_str_reward_id
					);

					if (!is_struct(_stct_card)){
						continue;
					}

					scr_deck_add_card(_stct_card);

					_ct_cards_awarded++;
				}

				if (_ct_cards_awarded > 0){

					scr_debug_log(
						"OVERWORLD",
						"TREASURE",
						self,
						"CUSTOM CHEST REWARD" +
						" | CHEST: " + string_upper(_str_chest_id) +
						" | CARD: " + string_upper(_str_reward_id) +
						" | AMOUNT: " + string(_ct_cards_awarded),
						"REWARD",
						"OBJ_OVERWORLD_TREASURE_CHEST:HSCR_OVERWORLD_TREASURE_AWARD_CUSTOM_LOOT"
					);
				}

			break;

			//======//
			//ITEM//
			//======//
			case "ITEM":

				scr_inventory_add_item(
					_str_reward_id,
					_ct_reward_amount
				);

				scr_debug_log(
					"OVERWORLD",
					"TREASURE",
					self,
					"CUSTOM CHEST REWARD" +
					" | CHEST: " + string_upper(_str_chest_id) +
					" | ITEM: " + string_upper(_str_reward_id) +
					" | AMOUNT: " + string(_ct_reward_amount),
					"REWARD",
					"OBJ_OVERWORLD_TREASURE_CHEST:HSCR_OVERWORLD_TREASURE_AWARD_CUSTOM_LOOT"
				);

			break;

			//======//
			//GOLD//
			//======//
			case "GOLD":

				global.val_player_gold += _ct_reward_amount;

				scr_debug_log(
					"OVERWORLD",
					"TREASURE",
					self,
					"CUSTOM CHEST REWARD" +
					" | CHEST: " + string_upper(_str_chest_id) +
					" | GOLD: +" + string(_ct_reward_amount) +
					" | PLAYER GOLD: " +
					string(global.val_player_gold),
					"REWARD",
					"OBJ_OVERWORLD_TREASURE_CHEST:HSCR_OVERWORLD_TREASURE_AWARD_CUSTOM_LOOT"
				);

			break;
		}

		//================//
		//SHOW REWARD//
		//================//
		if (instance_exists(obj_player)){

			var _val_popup_x =
				obj_player.x +
				irandom_range(-128,128);

			var _val_popup_y =
				obj_player.y +
				irandom_range(-128,128);

			scr_gui_spawn_popup(
				"TEXT",
				"+" +
				_str_reward_id +
				"x" +
				string(_ct_reward_amount),
				undefined,
				c_white,
				_val_popup_x,
				_val_popup_y
			);
		}
	}

	//================//
	//DEBUG COMPLETE//
	//================//
	scr_debug_log(
		"OVERWORLD",
		"TREASURE",
		self,
		"CUSTOM CHEST REWARDS COMPLETE" +
		" | CHEST: " + string_upper(_str_chest_id) +
		" | REWARD ENTRIES: " +
		string(array_length(_arr_rewards)),
		"REWARD",
		"OBJ_OVERWORLD_TREASURE_CHEST:HSCR_OVERWORLD_TREASURE_AWARD_CUSTOM_LOOT"
	);
};

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_AWARD_RANDOM_LOOT
// FUNCTION: Rolls random Card or Item rewards based on chest rarity.
//           Awards rarity-scaled Gold alongside each loot roll.
//           Logs each completed random reward slot.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_award_random_loot = function(){

	for (var _it_loot = 0;_it_loot < _ct_loot_rewards;_it_loot++){

		var _str_reward_type = choose(
			"ITEM",
			"CARD"
		);

		var _list_card_pool = global.list_pool_cards_rarity_I;

		var _str_primary_reward = "NONE";

		//================//
		//SELECT CARD POOL//
		//================//
		switch (_str_rarity){

			case "II":
				_list_card_pool = global.list_pool_cards_rarity_II;
			break;

			case "III":
				_list_card_pool = global.list_pool_cards_rarity_III;
			break;
		}

		//================//
		//AWARD CARD//
		//================//
		if (_str_reward_type == "CARD"){

			if (
				ds_exists(_list_card_pool,ds_type_list) &&
				ds_list_size(_list_card_pool) > 0
			){

				var _it_card_roll = irandom(
					ds_list_size(_list_card_pool) - 1
				);

				var _str_card_id = ds_list_find_value(
					_list_card_pool,
					_it_card_roll
				);

				var _stct_card = scr_card_get_info(
					_str_card_id
				);

				if (is_struct(_stct_card)){

					scr_deck_add_card(_stct_card);

					_str_primary_reward =
						"CARD: " +
						string_upper(_str_card_id);

					if (instance_exists(obj_player)){

						var _val_popup_x =
							obj_player.x +
								irandom_range(-48,48);

						var _val_popup_y =
							obj_player.y +
								irandom_range(-48,48);

						scr_gui_spawn_popup(
							"TEXT",
							"+" + _str_card_id,
							undefined,
							c_white,
							_val_popup_x,
							_val_popup_y
						);
					}
				}
			}
			else{

				scr_debug_log(
					"OVERWORLD",
					"TREASURE",
					self,
					"RANDOM CHEST CARD REWARD FAILED" +
					" | RARITY: " + string_upper(_str_rarity) +
					" | REASON: EMPTY CARD POOL",
					"WARNING",
					"OBJ_OVERWORLD_TREASURE_CHEST:HSCR_OVERWORLD_TREASURE_AWARD_RANDOM_LOOT"
				);
			}
		}

		//================//
		//AWARD ITEM//
		//================//
		else{

			var _str_item_id = scr_inventory_get_random_item(
				global.list_pool_items
			);

			if (_str_item_id != undefined){

				scr_inventory_add_item(
					_str_item_id,
					1
				);

				_str_primary_reward =
					"ITEM: " +
					string_upper(_str_item_id);

				if (instance_exists(obj_player)){

					var _val_popup_x =
						obj_player.x +
							irandom_range(-48,48);

					var _val_popup_y =
						obj_player.y +
							irandom_range(-48,48);

					scr_gui_spawn_popup(
						"TEXT",
						"+" + string(_str_item_id),
						undefined,
						c_black,
						_val_popup_x,
						_val_popup_y
					);
				}
			}
			else{

				scr_debug_log(
					"OVERWORLD",
					"TREASURE",
					self,
					"RANDOM CHEST ITEM REWARD FAILED" +
					" | RARITY: " + string_upper(_str_rarity) +
					" | REASON: NO VALID ITEM",
					"WARNING",
					"OBJ_OVERWORLD_TREASURE_CHEST:HSCR_OVERWORLD_TREASURE_AWARD_RANDOM_LOOT"
				);
			}
		}

		//================//
		//AWARD GOLD//
		//================//
		var _val_gold_reward = 50;

		if (_str_rarity == "II"){
			_val_gold_reward = 150;
		}
		else if (_str_rarity == "III"){
			_val_gold_reward = 300;
		}

		global.val_player_gold += _val_gold_reward;

		if (instance_exists(obj_player)){

			var _val_popup_x =
				obj_player.x +
					irandom_range(-48,48);

			var _val_popup_y =
				obj_player.y +
					irandom_range(-48,48);

			scr_gui_spawn_popup(
				"TEXT",
				"+" +
				string(_val_gold_reward) +
				"gp",
				undefined,
				c_yellow,
				_val_popup_x,
				_val_popup_y
			);
		}

		//================//
		//DEBUG REWARD//
		//================//
		scr_debug_log(
			"OVERWORLD",
			"TREASURE",
			self,
			"RANDOM CHEST REWARD" +
			" | SLOT: " +
			string(_it_loot + 1) +
			"/" +
			string(_ct_loot_rewards) +
			" | RARITY: " +
			string_upper(_str_rarity) +
			" | " +
			_str_primary_reward +
			" | GOLD: +" +
			string(_val_gold_reward) +
			" | PLAYER GOLD: " +
			string(global.val_player_gold),
			"REWARD",
			"OBJ_OVERWORLD_TREASURE_CHEST:HSCR_OVERWORLD_TREASURE_AWARD_RANDOM_LOOT"
		);
	}

	//================//
	//DEBUG COMPLETE//
	//================//
	scr_debug_log(
		"OVERWORLD",
		"TREASURE",
		self,
		"RANDOM CHEST REWARDS COMPLETE" +
		" | RARITY: " +
		string_upper(_str_rarity) +
		" | REWARD SLOTS: " +
		string(_ct_loot_rewards),
		"REWARD",
		"OBJ_OVERWORLD_TREASURE_CHEST:HSCR_OVERWORLD_TREASURE_AWARD_RANDOM_LOOT"
	);
};

#endregion