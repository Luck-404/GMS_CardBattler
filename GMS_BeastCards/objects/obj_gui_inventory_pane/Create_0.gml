//===============================================================================//
//
// CREATE: OBJ_GUI_INVENTORY_PANE
// FUNCTION: Initializes inventory pane layout, paging, sorting, and filter state.
//           Creates inventory page arrows.
//           Defines inventory-specific GUI drawing and interaction helpers.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
_str_type = "INVENTORY";

_val_pane_w = 800;
_val_pane_h = 800;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_slot_h = 60;
_val_slot_spacing = 3;
_val_slot_margin = 0;
_val_slot_w = 770;

_val_inventory_x = _val_pane_left + 15;
_val_start_y = _val_pane_top + 20;

_ct_inventory_per_page = 10;
_it_inventory_page = 0;

_val_page_y = _val_pane_top + _val_pane_h - 35;
_val_page_center_x = _val_pane_left + (_val_pane_w * 0.5);
_val_arrow_offset = 80;

_stct_preview_item = undefined;
_val_preview_scale = 4;

_str_sort_mode = "RECENT";
_str_filter_mode = "ALL";

_flag_clicked = false;
_ct_cooldown = 15;

_flag_prompt_active = false;
_ct_input_lockout = 0;

_stct_item_selected = undefined;
_ref_item_prompt = undefined;

_list_filtered_inventory = ds_list_create();

_ct_inventory_filtered = 0;
_ct_inventory_total_pages = 1;

_ct_inventory_seen_revision = -1;
_flag_inventory_dirty = true;

_ref_left_arrow = undefined;
_ref_right_arrow = undefined;

//================//
//INIT//
//================//
depth = -1;

_ref_left_arrow = instance_create_layer(
	_val_page_center_x - _val_arrow_offset,
	_val_page_y,
	"ily_fx",
	obj_gui_inventory_left_arrow
);

_ref_left_arrow._ref_gui_pane = self;

_ref_right_arrow = instance_create_layer(
	_val_page_center_x + _val_arrow_offset,
	_val_page_y,
	"ily_fx",
	obj_gui_inventory_right_arrow
);

_ref_right_arrow._ref_gui_pane = self;

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_START_INPUT_LOCKOUT
// FUNCTION: Locks inventory input briefly after closing a prompt or sub-GUI.
//           Prevents the same click from reaching the inventory underneath.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_start_input_lockout(){

	_ct_input_lockout = 15;

	_flag_clicked = true;
	_ct_cooldown = _ct_input_lockout;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_UPDATE_INPUT_LOCKOUT
// FUNCTION: Updates the inventory input lockout timer.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_update_input_lockout(){

	if (_ct_input_lockout > 0){
		_ct_input_lockout--;
	}
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_CAN_ACCEPT_INPUT
// FUNCTION: Returns whether the inventory can currently process input.
//
// ARGUMENTS: None.
// RETURNS: True if inventory input is available, otherwise false.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_can_accept_input(){

	if (_flag_prompt_active){
		return false;
	}

	if (_ct_input_lockout > 0){
		return false;
	}

	return true;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_OPEN_ITEM_PROMPT
// FUNCTION: Opens an item-use prompt for supported inventory item types.
//           Assigns the appropriate item-use callback to the prompt.
//
// ARGUMENTS: _stct_item is the selected inventory item.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_open_item_prompt(_stct_item){

	if (_flag_prompt_active){
		return;
	}

	if (_stct_item == undefined){
		return;
	}

	//----------------//
	//GET CALLBACK//
	//----------------//
	var _scr_yes_callback = undefined;

	switch (_stct_item._str_item_type){

		case "PRISM":
			_scr_yes_callback = scr_inventory_use_prism_overworld;
		break;

		case "EGG":
			_scr_yes_callback = scr_inventory_use_egg_item;
		break;

		case "CONSUMABLE":
			_scr_yes_callback = scr_inventory_use_consumable_item;
		break;

		case "QUEST":
			_scr_yes_callback = scr_inventory_use_quest_item;
		break;

		case "HELD":
			_scr_yes_callback = scr_inventory_use_held_item;
		break;

		default:
			return;
		break;
	}

	//----------------//
	//LOG ITEM CLICK//
	//----------------//
	scr_debug_log(
		"INVENTORY",
		"ITEM",
		self,
		"Clicked item: " +
		string(_stct_item._str_item_name) +
		" | Type: " +
		string(_stct_item._str_item_type)
	);

	//----------------//
	//CREATE PROMPT//
	//----------------//
	_flag_prompt_active = true;
	_stct_item_selected = _stct_item;

	_ref_item_prompt = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_prompt
	);

	_ref_item_prompt._ref_parent_gui = self;
	_ref_item_prompt._stct_item = _stct_item;

	_ref_item_prompt._str_prompt_text = "USE " + string(_stct_item._str_item_name) + "?";
	_ref_item_prompt._str_yes_text = "YES";
	_ref_item_prompt._str_no_text = "NO";

	_ref_item_prompt._scr_yes = _scr_yes_callback;
	_ref_item_prompt._scr_no = scr_inventory_cancel_item_use;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_UPDATE_CLICK_COOLDOWN
// FUNCTION: Updates the inventory click cooldown.
//           Prevents repeated actions from a single input.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_update_click_cooldown(){

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

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_MARK_DIRTY
// FUNCTION: Marks the cached inventory display list for rebuilding.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_mark_dirty(){

	_flag_inventory_dirty = true;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_REFRESH_CACHE
// FUNCTION: Rebuilds the cached filtered and sorted inventory when needed.
//           Refreshes pagination after inventory, sort, or filter changes.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_refresh_cache(){

	if (
		!_flag_inventory_dirty &&
		_ct_inventory_seen_revision == global.ct_inventory_revision
	){
		return;
	}

	//----------------//
	//BUILD CACHE//
	//----------------//
	ds_list_clear(_list_filtered_inventory);

	var _list_new = hscr_gui_inventory_build_filtered();

	hscr_gui_inventory_sort(_list_new);

	for (var _it_item = 0; _it_item < ds_list_size(_list_new); _it_item++){

		var _stct_item = ds_list_find_value(_list_new,_it_item);

		ds_list_add(_list_filtered_inventory,_stct_item);
	}

	ds_list_destroy(_list_new);

	//----------------//
	//UPDATE PAGING//
	//----------------//
	_ct_inventory_filtered = ds_list_size(_list_filtered_inventory);
	_ct_inventory_total_pages = max(1,ceil(_ct_inventory_filtered / _ct_inventory_per_page));

	_it_inventory_page = clamp(_it_inventory_page,0,_ct_inventory_total_pages - 1);

	//----------------//
	//CACHE REVISION//
	//----------------//
	_ct_inventory_seen_revision = global.ct_inventory_revision;
	_flag_inventory_dirty = false;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_BUILD_FILTERED
// FUNCTION: Builds a temporary filtered inventory list.
//           Reads inventory backward when sorting by recent.
//
// ARGUMENTS: None.
// RETURNS: A newly created filtered DS list.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_build_filtered(){

	var _list_filtered = ds_list_create();

	//----------------//
	//RECENT ORDER//
	//----------------//
	if (_str_sort_mode == "RECENT"){

		for (var _it_item = ds_list_size(global.list_player_inventory) - 1; _it_item >= 0; _it_item--){

			var _stct_item = ds_list_find_value(global.list_player_inventory,_it_item);

			if (_stct_item == undefined){
				continue;
			}

			if (_str_filter_mode != "ALL" && _stct_item._str_item_type != _str_filter_mode){
				continue;
			}

			ds_list_add(_list_filtered,_stct_item);
		}
	}

	//----------------//
	//STANDARD ORDER//
	//----------------//
	else{

		for (var _it_item = 0; _it_item < ds_list_size(global.list_player_inventory); _it_item++){

			var _stct_item = ds_list_find_value(global.list_player_inventory,_it_item);

			if (_stct_item == undefined){
				continue;
			}

			if (_str_filter_mode != "ALL" && _stct_item._str_item_type != _str_filter_mode){
				continue;
			}

			ds_list_add(_list_filtered,_stct_item);
		}
	}

	return _list_filtered;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_GET_ITEM_TYPE_ORDER
// FUNCTION: Returns the sorting priority for an inventory item type.
//
// ARGUMENTS: _str_item_type is the inventory item type.
// RETURNS: Numeric sorting priority.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_get_item_type_order(_str_item_type){

	switch (_str_item_type){

		case "CONSUMABLE":
			return 0;

		case "EGG":
			return 1;

		case "HELD":
			return 2;

		case "PRISM":
			return 3;

		case "QUEST":
			return 4;
	}

	return 99;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_SORT
// FUNCTION: Sorts a temporary inventory list using the active sort mode.
//
// ARGUMENTS: _list_filtered is the temporary inventory list to sort.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_sort(_list_filtered){

	var _ct_filtered = ds_list_size(_list_filtered);

	for (var _it_a = 0; _it_a < _ct_filtered - 1; _it_a++){

		for (var _it_b = _it_a + 1; _it_b < _ct_filtered; _it_b++){

			var _stct_a = ds_list_find_value(_list_filtered,_it_a);
			var _stct_b = ds_list_find_value(_list_filtered,_it_b);

			var _flag_swap = false;

			switch (_str_sort_mode){

				case "ALPHABETICAL":
					_flag_swap = string_lower(_stct_a._str_item_name) > string_lower(_stct_b._str_item_name);
				break;

				case "TYPE":
					_flag_swap =
						hscr_gui_inventory_get_item_type_order(_stct_a._str_item_type) >
						hscr_gui_inventory_get_item_type_order(_stct_b._str_item_type);
				break;

				case "RECENT":
					_flag_swap = false;
				break;
			}

			if (_flag_swap){
				ds_list_replace(_list_filtered,_it_a,_stct_b);
				ds_list_replace(_list_filtered,_it_b,_stct_a);
			}
		}
	}
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_GET_ITEM_TYPE_COLOR
// FUNCTION: Returns the display color associated with an inventory item type.
//
// ARGUMENTS: _str_item_type is the inventory item type.
// RETURNS: Display color for the supplied type.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_get_item_type_color(_str_item_type){

	switch (_str_item_type){

		case "QUEST":
			return c_yellow;

		case "CONSUMABLE":
			return c_green;

		case "PRISM":
			return c_aqua;

		case "HELD":
			return make_colour_rgb(255,140,0);

		case "EGG":
			return make_colour_rgb(180,100,255);
	}

	return global.c_dk_gray;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_UPDATE_LAYOUT
// FUNCTION: Recalculates inventory slot layout values.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_update_layout(){

	_ct_inventory_per_page = 10;

	var _val_usable_h = _val_pane_h - 90;
	var _val_total_spacing = (_ct_inventory_per_page - 1) * 3;

	_val_slot_spacing = 3;
	_val_slot_h = (_val_usable_h - _val_total_spacing) / _ct_inventory_per_page;
	_val_slot_h = max(40,_val_slot_h);

	_val_slot_w = 770;

	_val_inventory_x = _val_pane_left + 15;
	_val_start_y = _val_pane_top + 20;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_DRAW_SLOTS
// FUNCTION: Draws the currently visible inventory item slots.
//
// ARGUMENTS: _list_filtered is the filtered inventory display list.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_draw_slots(_list_filtered){

	var _ct_filtered = ds_list_size(_list_filtered);
	var _it_start_index = _it_inventory_page * _ct_inventory_per_page;
	var _val_box_x = _val_inventory_x;

	for (var _it_slot = 0; _it_slot < _ct_inventory_per_page; _it_slot++){

		var _it_item = _it_start_index + _it_slot;

		if (_it_item >= _ct_filtered){
			break;
		}

		var _stct_item = ds_list_find_value(_list_filtered,_it_item);
		var _val_box_y = _val_start_y + _it_slot * (_val_slot_h + _val_slot_spacing);
		var _c_slot = hscr_gui_inventory_get_item_type_color(_stct_item._str_item_type);

		//----------------//
		//DRAW SLOT//
		//----------------//
		draw_set_colour(c_black);
		draw_rectangle(
			_val_box_x,
			_val_box_y,
			_val_box_x + _val_slot_w,
			_val_box_y + _val_slot_h,
			false
		);

		draw_set_colour(_c_slot);
		draw_rectangle(
			_val_box_x + 2,
			_val_box_y + 2,
			_val_box_x + _val_slot_w - 2,
			_val_box_y + _val_slot_h - 2,
			false
		);

		//----------------//
		//DRAW ITEM//
		//----------------//
		draw_sprite_ext(
			_stct_item._spr_item,
			0,
			_val_box_x + 20,
			_val_box_y + (_val_slot_h * 0.5),
			1,
			1,
			0,
			c_white,
			1
		);

		draw_set_colour(c_black);

		var _str_item_text = _stct_item._str_item_name;

		if (_stct_item._flag_stackable){
			_str_item_text += " x" + string(_stct_item._ct_item_amount);
		}

		draw_text(_val_box_x + 60,_val_box_y + 28,_str_item_text);

		//----------------//
		//HANDLE HOVER//
		//----------------//
		var _flag_hover =
			device_mouse_x_to_gui(0) > _val_box_x &&
			device_mouse_x_to_gui(0) < _val_box_x + _val_slot_w &&
			device_mouse_y_to_gui(0) > _val_box_y &&
			device_mouse_y_to_gui(0) < _val_box_y + _val_slot_h;

		if (_flag_hover && hscr_gui_inventory_can_accept_input()){

			draw_set_colour(c_white);
			draw_rectangle(
				_val_box_x - 2,
				_val_box_y - 2,
				_val_box_x + _val_slot_w + 2,
				_val_box_y + _val_slot_h + 2,
				true
			);

			if (keyboard_check(vk_lcontrol)){
				_stct_preview_item = _stct_item;
			}

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

				audio_play_sound(snd_gui_press,0,false);

				_flag_clicked = true;
				_ct_cooldown = 10;

				hscr_gui_inventory_open_item_prompt(_stct_item);
			}
		}
	}
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_DRAW_PAGE_TEXT
// FUNCTION: Draws the current inventory page indicator.
//
// ARGUMENTS: _ct_total_pages is the total number of inventory pages.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_draw_page_text(_ct_total_pages){

	draw_set_colour(c_black);
	draw_set_halign(fa_center);

	draw_text(
		_val_page_center_x,
		_val_page_y,
		"PAGE " + string(_it_inventory_page + 1) + "/" + string(_ct_total_pages)
	);

	draw_set_halign(fa_left);
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_HANDLE_SORT_FILTER_INPUT
// FUNCTION: Handles inventory sort and filter button input.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_handle_sort_filter_input(){

	if (!hscr_gui_inventory_can_accept_input()){
		return;
	}

	if (_flag_clicked){
		return;
	}

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _val_sort_x = _val_pane_left + 20;
	var _val_sort_y = _val_pane_top + _val_pane_h - 70;

	var _val_filter_x = _val_pane_left + _val_pane_w - 220;
	var _val_filter_y = _val_sort_y;

	var _flag_sort_hover =
		_val_mouse_x > _val_sort_x &&
		_val_mouse_x < _val_sort_x + 200 &&
		_val_mouse_y > _val_sort_y &&
		_val_mouse_y < _val_sort_y + 25;

	var _flag_filter_hover =
		_val_mouse_x > _val_filter_x &&
		_val_mouse_x < _val_filter_x + 200 &&
		_val_mouse_y > _val_filter_y &&
		_val_mouse_y < _val_filter_y + 25;

	if (!mouse_check_button_pressed(mb_left)){
		return;
	}

	//----------------//
	//SORT MODE//
	//----------------//
	if (_flag_sort_hover){

		audio_play_sound(snd_gui_press,0,false);

		switch (_str_sort_mode){

			case "RECENT":
				_str_sort_mode = "TYPE";
			break;

			case "TYPE":
				_str_sort_mode = "ALPHABETICAL";
			break;

			case "ALPHABETICAL":
				_str_sort_mode = "RECENT";
			break;
		}

		_it_inventory_page = 0;

		_flag_clicked = true;
		_ct_cooldown = 10;

		hscr_gui_inventory_mark_dirty();

		return;
	}

	//----------------//
	//FILTER MODE//
	//----------------//
	if (_flag_filter_hover){

		audio_play_sound(snd_gui_press,0,false);

		switch (_str_filter_mode){

			case "ALL":
				_str_filter_mode = "CONSUMABLE";
			break;

			case "CONSUMABLE":
				_str_filter_mode = "EGG";
			break;

			case "EGG":
				_str_filter_mode = "HELD";
			break;

			case "HELD":
				_str_filter_mode = "PRISM";
			break;

			case "PRISM":
				_str_filter_mode = "QUEST";
			break;

			case "QUEST":
				_str_filter_mode = "ALL";
			break;
		}

		_it_inventory_page = 0;

		_flag_clicked = true;
		_ct_cooldown = 10;

		hscr_gui_inventory_mark_dirty();
	}
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_DRAW_SORT_FILTER_BUTTONS
// FUNCTION: Draws inventory sort and filter controls.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_draw_sort_filter_buttons(){

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	//----------------//
	//SORT BUTTON//
	//----------------//
	var _val_sort_x = _val_pane_left + 20;
	var _val_sort_y = _val_pane_top + _val_pane_h - 70;

	var _flag_sort_hover =
		_val_mouse_x > _val_sort_x &&
		_val_mouse_x < _val_sort_x + 200 &&
		_val_mouse_y > _val_sort_y &&
		_val_mouse_y < _val_sort_y + 25;

	draw_set_colour(_flag_sort_hover ? c_white : global.c_dk_gray);
	draw_rectangle(_val_sort_x,_val_sort_y,_val_sort_x + 200,_val_sort_y + 25,false);

	draw_set_colour(c_black);
	draw_text(_val_sort_x + 5,_val_sort_y + 5,"SORT: " + _str_sort_mode);

	//----------------//
	//FILTER BUTTON//
	//----------------//
	var _val_filter_x = _val_pane_left + _val_pane_w - 220;
	var _val_filter_y = _val_sort_y;

	var _flag_filter_hover =
		_val_mouse_x > _val_filter_x &&
		_val_mouse_x < _val_filter_x + 200 &&
		_val_mouse_y > _val_filter_y &&
		_val_mouse_y < _val_filter_y + 25;

	draw_set_colour(_flag_filter_hover ? c_white : global.c_dk_gray);
	draw_rectangle(_val_filter_x,_val_filter_y,_val_filter_x + 200,_val_filter_y + 25,false);

	draw_set_colour(c_black);
	draw_text(_val_filter_x + 5,_val_filter_y + 5,"FILTER: " + _str_filter_mode);
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_INVENTORY_DRAW_PREVIEW_MODAL
// FUNCTION: Draws the held-control inventory item preview modal.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_inventory_draw_preview_modal(){

	if (_stct_preview_item == undefined || !keyboard_check(vk_lcontrol)){
		return;
	}

	var _val_center_x = display_get_gui_width() * 0.5;
	var _val_center_y = display_get_gui_height() * 0.5;

	//----------------//
	//PREVIEW PANE//
	//----------------//
	draw_set_colour(c_black);
	draw_rectangle(
		_val_center_x - 300,
		_val_center_y - 300,
		_val_center_x + 300,
		_val_center_y + 300,
		false
	);

	//----------------//
	//ITEM SPRITE//
	//----------------//
	draw_sprite_ext(
		_stct_preview_item._spr_item,
		0,
		_val_center_x,
		_val_center_y - 40,
		_val_preview_scale,
		_val_preview_scale,
		0,
		c_white,
		1
	);

	//----------------//
	//ITEM INFO//
	//----------------//
	draw_set_colour(c_white);
	draw_text(
		_val_center_x - 120,
		_val_center_y + 80,
		_stct_preview_item._str_item_name
	);

	draw_set_colour(c_ltgray);
	draw_text_ext(
		_val_center_x - 120,
		_val_center_y + 100,
		_stct_preview_item._str_item_desc,
		16,
		300
	);
}

#endregion