//===============================================================================//
//
// CREATE: OBJ_GUI_ITEM_TARGET_PANE
// FUNCTION: Initializes item target selection pane.
//           Displays party targets on the left and selected item data on the right.
//           Used by consumable items that target party beasts.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -102;

_str_type = "ITEM_TARGET_PANE";

_ref_parent_gui = undefined;
_stct_item = undefined;

_str_target_mode = "PARTY";

_val_pane_w = 700;
_val_pane_h = 500;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_slot_w = 360;
_val_slot_h = 70;
_val_slot_spacing = 8;

_val_left_x = _val_pane_left + 24;
_val_right_x = _val_pane_left + 430;

_val_start_y = _val_pane_top + 70;

_flag_clicked = false;
_ct_cooldown = 8;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_get_current_item_amount
// FUNCTION: Returns the current inventory amount for this pane's item.
//           Uses item uid so the pane tracks the exact stack being used.
//—------------------------------------------------------------------------------//
function hscr_get_current_item_amount(){

	if (_stct_item == undefined){
		return 0;
	}

	for (var _it_item = 0; _it_item < ds_list_size(global.list_player_inventory); _it_item++){

		var _stct_check_item = ds_list_find_value(global.list_player_inventory,_it_item);

		if (_stct_check_item == undefined){
			continue;
		}

		if (_stct_check_item._uid_item == _stct_item._uid_item){
			return _stct_check_item._ct_item_amount;
		}
	}

	return 0;
}

//—------------------------------------------------------------------------------//
// hscr_get_current_item_ref
// FUNCTION: Returns the current item stack struct from inventory.
//           Prevents stale stack data after repeated item use.
//
//—------------------------------------------------------------------------------//
function hscr_get_current_item_ref(){

	if (_stct_item == undefined){
		return undefined;
	}

	for (var _it_item = 0; _it_item < ds_list_size(global.list_player_inventory); _it_item++){

		var _stct_check_item = ds_list_find_value(global.list_player_inventory,_it_item);

		if (_stct_check_item == undefined){
			continue;
		}

		if (_stct_check_item._uid_item == _stct_item._uid_item){
			return _stct_check_item;
		}
	}

	return undefined;
}

//—------------------------------------------------------------------------------//
// hscr_close_target_pane
// FUNCTION: Closes the item target pane.
//           Reactivates the parent inventory pane.
//           Starts input lockout to prevent click-through.
//—------------------------------------------------------------------------------//
function hscr_close_target_pane(){

	if (instance_exists(_ref_parent_gui)){
		_ref_parent_gui._flag_prompt_active = false;
		_ref_parent_gui.hscr_mark_inventory_dirty();
		_ref_parent_gui.hscr_start_input_lockout();
	}

	instance_destroy();
}

//—------------------------------------------------------------------------------//
// hscr_update_click_cooldown
// FUNCTION: Updates pane click cooldown.
//           Prevents repeated item uses from one mouse press.
//—------------------------------------------------------------------------------//
function hscr_update_click_cooldown(){

	if (_flag_clicked){
		if (_ct_cooldown > 0){
			_ct_cooldown--;
		}
		else{
			_ct_cooldown = 0;
			_flag_clicked = false;
		}
	}
}

#endregion