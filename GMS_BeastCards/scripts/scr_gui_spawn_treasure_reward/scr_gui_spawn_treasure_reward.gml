//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_TREASURE_REWARD
// FUNCTION: Creates a dedicated overworld treasure reward notification.
//
//           Treasure rewards are completely independent of the normal PRINTOUT
//           presentation modes.
//
//           Rewards appear in outlined boxes at the bottom-right of the GUI,
//           stack vertically upward, remain fully visible for 120 frames,
//           then fade over 60 frames.
//
//           ITEM rewards whose ids begin with EGG_ are displayed as EGG rewards.
//
// ARGUMENTS: _str_reward_type - CARD, ITEM, EGG, or GOLD.
//            _str_reward_id - Reward id. Undefined for Gold.
//            _ct_amount - Amount awarded.
// RETURNS: Created treasure reward GUI instance.
//
//===============================================================================//

function scr_gui_spawn_treasure_reward(_str_reward_type,_str_reward_id,_ct_amount=1){

	#region VALIDATION

	//================//
	//VALIDATE AMOUNT//
	//================//
	_ct_amount = max(1,floor(_ct_amount));

	//================//
	//NORMALIZE TYPE//
	//================//
	_str_reward_type =
		string_upper(string(_str_reward_type));

	var _str_reward_id_upper = "";

	if (_str_reward_id != undefined){
		_str_reward_id_upper =
			string_upper(string(_str_reward_id));
	}

	//================//
	//DETECT EGG//
	//================//
	if (
		_str_reward_type == "ITEM" &&
		string_pos("EGG_",_str_reward_id_upper) == 1
	){
		_str_reward_type = "EGG";
	}

	#endregion

	#region DISPLAY DATA

	//================//
	//DISPLAY DEFAULTS//
	//================//
	var _str_display_text = "";
	var _c_text = c_white;

	//================//
	//FORMAT REWARD//
	//================//
	switch (_str_reward_type){

		//======//
		//GOLD//
		//======//
		case "GOLD":

			_str_display_text =
				"+" +
				string(_ct_amount) +
				" GP";

			_c_text = c_yellow;

		break;

		//======//
		//CARD//
		//======//
		case "CARD":

			var _str_card_name =
				string_replace_all(
					_str_reward_id_upper,
					"_",
					" "
				);

			_str_display_text =
				"CARD: " +
				_str_card_name;

			if (_ct_amount > 1){
				_str_display_text +=
					" x" +
					string(_ct_amount);
			}

		break;

		//=====//
		//EGG//
		//=====//
		case "EGG":

			var _str_egg_name =
				_str_reward_id_upper;

			if (string_pos("EGG_",_str_egg_name) == 1){
				_str_egg_name =
					string_delete(
						_str_egg_name,
						1,
						4
					);
			}

			_str_egg_name =
				string_replace_all(
					_str_egg_name,
					"_",
					" "
				);

			_str_display_text =
				"EGG: " +
				_str_egg_name;

			if (_ct_amount > 1){
				_str_display_text +=
					" x" +
					string(_ct_amount);
			}

		break;

		//======//
		//ITEM//
		//======//
		case "ITEM":

			var _str_item_name =
				string_replace_all(
					_str_reward_id_upper,
					"_",
					" "
				);

			_str_display_text =
				"ITEM: " +
				_str_item_name;

			if (_ct_amount > 1){
				_str_display_text +=
					" x" +
					string(_ct_amount);
			}

		break;

		//=======//
		//OTHER//
		//=======//
		default:

			_str_display_text =
				string_replace_all(
					_str_reward_id_upper,
					"_",
					" "
				);

			if (_ct_amount > 1){
				_str_display_text +=
					" x" +
					string(_ct_amount);
			}

		break;
	}

	#endregion

	#region CREATE

	//================//
	//ENSURE SERIAL//
	//================//
	if (!variable_global_exists("val_treasure_reward_serial")){
		global.val_treasure_reward_serial = 0;
	}

	global.val_treasure_reward_serial++;

	//================//
	//CREATE REWARD//
	//================//
	var _ref_reward = instance_create_layer(
		0,
		0,
		"ily_fx",
		obj_gui_treasure_reward
	);

	_ref_reward._str_reward_type =
		_str_reward_type;

	_ref_reward._str_text =
		_str_display_text;

	_ref_reward._c_text =
		_c_text;

	_ref_reward._val_reward_serial =
		global.val_treasure_reward_serial;

	#endregion

	#region DEBUG

	//================//
	//DEBUG REWARD//
	//================//
	scr_debug_log(
		"GUI",
		"TREASURE_REWARD",
		_ref_reward,
		"TREASURE REWARD NOTIFICATION CREATED" +
			" | TYPE: " +
			_str_reward_type +
			" | TEXT: " +
			_str_display_text +
			" | SERIAL: " +
			string(global.val_treasure_reward_serial),
		"INFO",
		"SCR_GUI_SPAWN_TREASURE_REWARD"
	);

	#endregion

	return _ref_reward;
}