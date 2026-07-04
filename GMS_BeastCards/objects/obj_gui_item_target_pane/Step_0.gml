//===============================================================================//
//
// STEP: OBJ_GUI_ITEM_TARGET_PANE
// FUNCTION: Handles item target selection.
//           Uses the selected item on clicked party members.
//           Closes on right click or when the item stack is depleted.
//
//===============================================================================//

//--------//
//COOLDOWN//
//--------//
hscr_update_click_cooldown();

//-------------//
//VALIDITY CHECK//
//-------------//
if (!instance_exists(_ref_parent_gui)){
	instance_destroy();
	exit;
}

if (_stct_item == undefined){
	hscr_close_target_pane();
	exit;
}

var _stct_current_item = hscr_get_current_item_ref();

if (_stct_current_item == undefined){
	hscr_close_target_pane();
	exit;
}

_stct_item = _stct_current_item;

if (hscr_get_current_item_amount() <= 0){
	hscr_close_target_pane();
	exit;
}

//-----------//
//RIGHT CLICK//
//-----------//
if (mouse_check_button_pressed(mb_right)){
	hscr_close_target_pane();
	exit;
}

//-------------//
//TARGET CLICKS//
//-------------//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

var _ct_party = ds_list_size(global.list_player_party);

for (var _it_unit = 0; _it_unit < _ct_party; _it_unit++){

	var _stct_unit = ds_list_find_value(global.list_player_party,_it_unit);

	if (_stct_unit == undefined){
		continue;
	}

	var _val_box_x = _val_left_x;
	var _val_box_y = _val_start_y + (_it_unit * (_val_slot_h + _val_slot_spacing));

	var _flag_hover = _val_mouse_x > _val_box_x && _val_mouse_x < _val_box_x + _val_slot_w && _val_mouse_y > _val_box_y && _val_mouse_y < _val_box_y + _val_slot_h;

	if (_flag_hover && mouse_check_button_pressed(mb_left) && !_flag_clicked){

		_flag_clicked = true;
		_ct_cooldown = 8;

		if (_stct_item._scr_item == undefined){
			scr_spawn_popup_scrolling(
				"TEXT",
				"NOTHING",
				undefined,
				c_white,
				_val_box_x + (_val_slot_w * 0.5),
				_val_box_y
			);

			exit;
		}

		var _flag_used = false;

		switch(_stct_item._str_item_type){

			case "CONSUMABLE":

				if (_stct_item._scr_item == undefined){

					scr_spawn_popup_scrolling(
						"TEXT",
						"NOTHING",
						undefined,
						c_white,
						_val_box_x + (_val_slot_w * 0.5),
						_val_box_y
					);

					exit;
				}

				_flag_used = _stct_item._scr_item(
					_stct_item,
					_stct_unit,
					_val_box_x + (_val_slot_w * 0.5),
					_val_box_y
				);

				if (_flag_used){
					scr_remove_item_from_inventory(_stct_item,1);

					if (instance_exists(_ref_parent_gui)){
						_ref_parent_gui.hscr_mark_inventory_dirty();
						_ref_parent_gui._ct_cooldown = 15;
					}

					_stct_current_item = hscr_get_current_item_ref();

					if (_stct_current_item == undefined || hscr_get_current_item_amount() <= 0){
						hscr_close_target_pane();
						exit;
					}

					_stct_item = _stct_current_item;
				}

			break;

			case "HELD":

				_flag_used = scr_use_inventory_held_item(
					_stct_item,
					_stct_unit,
					_val_box_x + (_val_slot_w * 0.5),
					_val_box_y
				);

				if (_flag_used){

					if (instance_exists(_ref_parent_gui)){
						_ref_parent_gui.hscr_mark_inventory_dirty();
						_ref_parent_gui._ct_cooldown = 15;
					}

					hscr_close_target_pane();
					exit;
				}

			break;
		}

		exit;
	}
}