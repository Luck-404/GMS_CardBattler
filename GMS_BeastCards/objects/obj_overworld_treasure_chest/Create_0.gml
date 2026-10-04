//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_TREASURE_CHEST
// FUNCTION: Initializes treasure chest loot state and persistence.
//           Rolls random chest rarity when required.
//           Defines helpers for rarity, loot awards, proximity audio,
//           and structured reward logging.
//
//           All successfully awarded treasure uses the dedicated
//           TREASURE_REWARD GUI system. Treasure rewards are independent
//           of the normal RANDOM/CLEAN PRINTOUT modes.
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
//
//           Each successfully awarded entry creates one dedicated bottom-right
//           Treasure Reward notification.
//
//           Inventory rewards beginning with EGG_ are automatically presented
//           as Egg rewards by SCR_GUI_SPAWN_TREASURE_REWARD.
//
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

					//================//
					//SHOW REWARD//
					//================//
					scr_gui_spawn_treasure_reward(
						"CARD",
						_str_reward_id,
						_ct_cards_awarded
					);

					//================//
					//DEBUG REWARD//
					//================//
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

				//================//
				//SHOW REWARD//
				//================//
				scr_gui_spawn_treasure_reward(
					"ITEM",
					_str_reward_id,
					_ct_reward_amount
				);

				//================//
				//DEBUG REWARD//
				//================//
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

				//================//
				//SHOW REWARD//
				//================//
				scr_gui_spawn_treasure_reward(
					"GOLD",
					undefined,
					_ct_reward_amount
				);

				//================//
				//DEBUG REWARD//
				//================//
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
//
//           Each successful Card/Item reward and each Gold award creates its own
//           dedicated bottom-right Treasure Reward notification.
//
//           Inventory rewards beginning with EGG_ are automatically presented
//           as Egg rewards by SCR_GUI_SPAWN_TREASURE_REWARD.
//
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

		var _arr_card_pool =
			global.arr_pool_cards_rarity_I;

		var _str_primary_reward = "NONE";

		//================//
		//SELECT CARD POOL//
		//================//
		switch (_str_rarity){

			case "II":

				_arr_card_pool =
					global.arr_pool_cards_rarity_II;

			break;

			case "III":

				_arr_card_pool =
					global.arr_pool_cards_rarity_III;

			break;
		}

		//================//
		//AWARD CARD//
		//================//
		if (_str_reward_type == "CARD"){

			if (
				is_array(_arr_card_pool) &&
				array_length(_arr_card_pool) > 0
			){

				var _it_card_roll =
					irandom(
						array_length(_arr_card_pool) - 1
					);

				var _str_card_id =
					_arr_card_pool[
						_it_card_roll
					];

				var _stct_card = scr_card_get_info(
					_str_card_id
				);

				if (is_struct(_stct_card)){

					scr_deck_add_card(_stct_card);

					_str_primary_reward =
						"CARD: " +
						string_upper(_str_card_id);

					//================//
					//SHOW REWARD//
					//================//
					scr_gui_spawn_treasure_reward(
						"CARD",
						_str_card_id,
						1
					);
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
				global.arr_pool_items
			);

			if (_str_item_id != undefined){

				scr_inventory_add_item(
					_str_item_id,
					1
				);

				_str_primary_reward =
					"ITEM: " +
						string_upper(_str_item_id);

				//================//
				//SHOW REWARD//
				//================//
				scr_gui_spawn_treasure_reward(
					"ITEM",
					_str_item_id,
					1
				);
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

		//================//
		//SHOW GOLD//
		//================//
		scr_gui_spawn_treasure_reward(
			"GOLD",
			undefined,
			_val_gold_reward
		);

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