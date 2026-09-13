//===============================================================================//
//
// STEP: OBJ_GUI_ITEM_TARGET_PANE
// FUNCTION: Handles Inventory item target selection.
//           Uses the selected Consumable or Held Item on clicked Party Beasts.
//           Logs successful Consumable use and closes when the selected stack
//           is depleted.
//
//===============================================================================//

//================//
//COOLDOWN//
//================//
hscr_gui_item_target_update_click_cooldown();

//================//
//VALIDITY CHECK//
//================//
if (!instance_exists(_ref_parent_gui)){

	instance_destroy();

	exit;
}

if (_stct_item == undefined){

	hscr_gui_item_target_close();

	exit;
}

var _stct_current_item = hscr_gui_item_target_get_item_struct();

if (_stct_current_item == undefined){

	hscr_gui_item_target_close();

	exit;
}

_stct_item = _stct_current_item;

if (hscr_gui_item_target_get_item_amount() <= 0){

	hscr_gui_item_target_close();

	exit;
}

//================//
//RIGHT CLICK//
//================//
if (mouse_check_button_pressed(mb_right)){

	audio_play_sound(
		snd_gui_close,
		0,
		false
	);

	hscr_gui_item_target_close();

	exit;
}

//================//
//TARGET CLICKS//
//================//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

var _ct_party = ds_list_size(global.list_player_party);

for (var _it_unit = 0;_it_unit < _ct_party;_it_unit++){

	var _stct_unit = ds_list_find_value(
		global.list_player_party,
		_it_unit
	);

	if (_stct_unit == undefined){
		continue;
	}

	var _val_box_x = _val_left_x;
	var _val_box_y = _val_start_y + (_it_unit * (_val_slot_h + _val_slot_spacing));

	var _flag_hover =
		_val_mouse_x > _val_box_x &&
		_val_mouse_x < _val_box_x + _val_slot_w &&
		_val_mouse_y > _val_box_y &&
		_val_mouse_y < _val_box_y + _val_slot_h;

	if (
		!_flag_hover ||
		!mouse_check_button_pressed(mb_left) ||
		_flag_clicked
	){
		continue;
	}

	_flag_clicked = true;
	_ct_cooldown = 8;

	//----------------//
	//VALIDATE EFFECT//
	//----------------//
	if (_stct_item._scr_item == undefined){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NOTHING",
			undefined,
			c_white,
			_val_box_x + (_val_slot_w * 0.5),
			_val_box_y
		);

		exit;
	}

	audio_play_sound(
		snd_inventory_use_item,
		0,
		false
	);

	var _flag_used = false;

	//================//
	//USE ITEM//
	//================//
	switch (_stct_item._str_item_type){

		//============//
		//CONSUMABLE//
		//============//
		case "CONSUMABLE":

			//----------------//
			//STORE TARGET HP//
			//----------------//
			var _val_hp_before = _stct_unit._val_beast_hp_cur;

			//----------------//
			//RESOLVE EFFECT//
			//----------------//
			_flag_used = _stct_item._scr_item(
				_stct_item,
				_stct_unit,
				_val_box_x + (_val_slot_w * 0.5),
				_val_box_y
			);

			if (_flag_used){

				var _val_hp_after = _stct_unit._val_beast_hp_cur;

				//----------------//
				//STORE ITEM DATA//
				//----------------//
				var _str_item_name = _stct_item._str_item_name;
				var _str_item_id = _stct_item._str_item_id;
				var _uid_item = _stct_item._uid_item;

				//----------------//
				//CONSUME ITEM//
				//----------------//
				var _flag_removed = scr_inventory_remove_item(
					_stct_item,
					1
				);

				//================//
				//DEBUG USE//
				//================//
				scr_debug_log(
					"INVENTORY",
					"USE",
					undefined,
					"CONSUMABLE USED" +
					" | ITEM: " +
					string_upper(_str_item_name) +
					" | ID: " +
					string_upper(_str_item_id) +
					" | UID: " +
					string(_uid_item) +
					" | TARGET: " +
					string_upper(_stct_unit._str_beast_name) +
					" | HP: " +
					string(_val_hp_before) +
					" -> " +
					string(_val_hp_after) +
					"/" +
					string(_stct_unit._val_beast_hp_max) +
					" | CONSUMED: " +
					(_flag_removed ? "YES" : "NO"),
					_flag_removed ? "INFO" : "ERROR",
					"OBJ_GUI_ITEM_TARGET_PANE:STEP"
				);

				//----------------//
				//REFRESH INVENTORY//
				//----------------//
				if (instance_exists(_ref_parent_gui)){

					_ref_parent_gui.hscr_gui_inventory_mark_dirty();
					_ref_parent_gui._ct_cooldown = 15;
				}

				_stct_current_item = hscr_gui_item_target_get_item_struct();

				if (
					_stct_current_item == undefined ||
					hscr_gui_item_target_get_item_amount() <= 0
				){

					hscr_gui_item_target_close();

					exit;
				}

				_stct_item = _stct_current_item;
			}

		break;

		//======//
		//HELD//
		//======//
		case "HELD":

			_flag_used = scr_inventory_equip_held_item(
				_stct_item,
				_stct_unit,
				_val_box_x + (_val_slot_w * 0.5),
				_val_box_y
			);

			if (_flag_used){

				if (instance_exists(_ref_parent_gui)){

					_ref_parent_gui.hscr_gui_inventory_mark_dirty();
					_ref_parent_gui._ct_cooldown = 15;
				}

				hscr_gui_item_target_close();

				exit;
			}

		break;
	}

	exit;
}