//===============================================================================//
//
// CREATE: OBJ_GUI_ITEM_TARGET_PANE
// FUNCTION: Initializes item target selection pane.
//           Displays Party targets on the left and selected Item data on the right.
//           Defines helpers for Item tracking, closing, and input cooldown.
//           Starts with input locked to prevent confirmation-click passthrough.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

//----------------//
//PANE STATE//
//----------------//
_str_type = "ITEM_TARGET_PANE";

_ref_parent_gui = undefined;
_stct_item = undefined;

_str_target_mode = "PARTY";

//--------//
//LAYOUT//
//--------//
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

//----------------//
//CLICK COOLDOWN//
//----------------//
_flag_clicked = true;
_ct_cooldown = 8;

#endregion

//----//
//INIT//
//----//
#region INIT

depth = -102;

#endregion

//-------//
//METHODS//
//-------//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_GUI_ITEM_TARGET_GET_ITEM_AMOUNT
// FUNCTION: Returns the current Inventory amount for this pane's Item.
//           Uses Item UID to track the exact stack being used.
//
// ARGUMENTS: None.
// RETURNS: Current Item amount, or 0 if the Item is no longer present.
//
//-------------------------------------------------------------------------------//
function hscr_gui_item_target_get_item_amount(){

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


//-------------------------------------------------------------------------------//
// HSCR_GUI_ITEM_TARGET_GET_ITEM_STRUCT
// FUNCTION: Returns the current Item stack struct from Inventory.
//           Prevents stale stack data after repeated Item use.
//
// ARGUMENTS: None.
// RETURNS: Current Item struct, or undefined if it is no longer present.
//
//-------------------------------------------------------------------------------//
function hscr_gui_item_target_get_item_struct(){

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


//-------------------------------------------------------------------------------//
// HSCR_GUI_ITEM_TARGET_CLOSE
// FUNCTION: Closes the Item target pane.
//           Reactivates the parent Inventory pane.
//           Starts input lockout to prevent click-through.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_item_target_close(){

	if (instance_exists(_ref_parent_gui)){

		_ref_parent_gui._flag_prompt_active = false;

		_ref_parent_gui.hscr_gui_inventory_mark_dirty();
		_ref_parent_gui.hscr_gui_inventory_start_input_lockout();
	}

	instance_destroy();
}


//-------------------------------------------------------------------------------//
// HSCR_GUI_ITEM_TARGET_UPDATE_CLICK_COOLDOWN
// FUNCTION: Updates the target-pane click cooldown.
//           Prevents the confirmation click that opened this pane from
//           immediately selecting a Party Beast.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_item_target_update_click_cooldown(){

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