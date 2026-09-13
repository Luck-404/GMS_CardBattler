//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_TREASURE_SPARKLE
// FUNCTION: Initializes a roaming treasure sparkle.
//           Rolls rarity, visibility, and starting position.
//           Defines helpers for sparkle behavior, audio, and rewards.
//           Logs the exact Card/Item and Gold granted when collected.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
#region VARIABLES

//----------------//
//TREASURE STATE//
//----------------//
_str_rarity = "";

_c_sparkle = c_white;

_flag_triggered = false;

//----------------//
//TIMERS//
//----------------//
_ct_visibility_timer = 300;
_ct_interaction_cooldown = 10;

//----------------//
//AUDIO//
//----------------//
_val_nearby_sound_handle = -1;

#endregion

//================//
//INIT//
//================//
#region INIT

#endregion

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_SPARKLE_STOP_NEARBY_SOUND
// FUNCTION: Stops this sparkle's looping proximity sound.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_sparkle_stop_nearby_sound = function(){

	if (_val_nearby_sound_handle == -1){
		return;
	}

	if (audio_is_playing(_val_nearby_sound_handle)){
		audio_stop_sound(_val_nearby_sound_handle);
	}

	_val_nearby_sound_handle = -1;
};

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_SPARKLE_ROLL_RARITY
// FUNCTION: Rolls the sparkle's treasure rarity.
//           Assigns the corresponding visual color.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_sparkle_roll_rarity = function(){

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
			_c_sparkle = c_white;
		break;

		case "II":
			_c_sparkle = c_lime;
		break;

		case "III":
			_c_sparkle = c_aqua;
		break;
	}
};

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_SPARKLE_ROLL_POSITION
// FUNCTION: Moves the treasure sparkle to a random room position.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_sparkle_roll_position = function(){

	x = irandom_range(
		32,
		room_width - 32
	);

	y = irandom_range(
		32,
		room_height - 32
	);
};

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_SPARKLE_ROLL_VISIBILITY
// FUNCTION: Randomly determines whether the sparkle is visible.
//           Resets its hidden-state reroll timer.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_sparkle_roll_visibility = function(){

	var _val_roll = irandom_range(
		1,
		100
	);

	visible = (_val_roll <= 50);

	_ct_visibility_timer = 300;

	if (!visible){
		hscr_overworld_treasure_sparkle_stop_nearby_sound();
	}
};

//-------------------------------------------------------------------------------//
// HSCR_OVERWORLD_TREASURE_SPARKLE_AWARD_REWARD
// FUNCTION: Awards a random Card or Item based on sparkle rarity.
//           Also grants a rarity-scaled Gold reward.
//           Logs the complete Sparkle reward in one line.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_overworld_treasure_sparkle_award_reward = function(){

	//================//
	//SELECT REWARD//
	//================//
	var _str_reward_type = choose(
		"ITEM",
		"CARD"
	);

	var _list_card_pool = global.list_pool_cards_rarity_I;

	var _str_primary_reward = "NONE";

	switch (_str_rarity){

		case "II":
			_list_card_pool = global.list_pool_cards_rarity_II;
		break;

		case "III":
			_list_card_pool = global.list_pool_cards_rarity_III;
		break;
	}

	//================//
	//CARD REWARD//
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
				"TREASURE_SPARKLE",
				self,
				"TREASURE SPARKLE CARD REWARD FAILED" +
				" | RARITY: " +
				string_upper(_str_rarity) +
				" | REASON: EMPTY CARD POOL",
				"WARNING",
				"OBJ_OVERWORLD_TREASURE_SPARKLE:HSCR_OVERWORLD_TREASURE_SPARKLE_AWARD_REWARD"
			);
		}
	}

	//================//
	//ITEM REWARD//
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
				"TREASURE_SPARKLE",
				self,
				"TREASURE SPARKLE ITEM REWARD FAILED" +
				" | RARITY: " +
				string_upper(_str_rarity) +
				" | REASON: NO VALID ITEM",
				"WARNING",
				"OBJ_OVERWORLD_TREASURE_SPARKLE:HSCR_OVERWORLD_TREASURE_SPARKLE_AWARD_REWARD"
			);
		}
	}

	//================//
	//GOLD REWARD//
	//================//
	var _val_gold_reward = 10;

	if (_str_rarity == "II"){
		_val_gold_reward = 25;
	}
	else if (_str_rarity == "III"){
		_val_gold_reward = 50;
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
		"TREASURE_SPARKLE",
		self,
		"TREASURE SPARKLE CLAIMED" +
		" | RARITY: " +
		string_upper(_str_rarity) +
		" | " +
		_str_primary_reward +
		" | GOLD: +" +
		string(_val_gold_reward) +
		" | PLAYER GOLD: " +
		string(global.val_player_gold),
		"REWARD",
		"OBJ_OVERWORLD_TREASURE_SPARKLE:HSCR_OVERWORLD_TREASURE_SPARKLE_AWARD_REWARD"
	);
};

#endregion

//================//
//INITIALIZE SPARKLE//
//================//
hscr_overworld_treasure_sparkle_roll_rarity();
hscr_overworld_treasure_sparkle_roll_position();
hscr_overworld_treasure_sparkle_roll_visibility();