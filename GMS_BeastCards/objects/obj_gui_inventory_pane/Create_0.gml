//===============================================================================//
//
// CREATE: OBJ_GUI_INVENTORY_PANE
// FUNCTION: Initializes inventory pane layout, paging, sorting, and filter state.
//           Creates inventory page arrows.
//           Defines helper scripts for inventory GUI drawing and interaction.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -1;

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
_ct_inventory_page = 0;

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

//----//
//INIT//
//----//
_ref_left_arrow = instance_create_layer(_val_page_center_x - _val_arrow_offset,_val_page_y,"ily_fx",obj_gui_inventory_left_arrow);
_ref_left_arrow._ref_gui_pane = self;

_ref_right_arrow = instance_create_layer(_val_page_center_x + _val_arrow_offset,_val_page_y,"ily_fx",obj_gui_inventory_right_arrow);
_ref_right_arrow._ref_gui_pane = self;

//-------//
//METHODS//
//-------//
#region METHODS
//—------------------------------------------------------------------------------//
// hscr_start_input_lockout
// FUNCTION: Locks inventory input briefly after closing prompt/sub-GUI.
//           Prevents the same click from hitting inventory underneath.
//—------------------------------------------------------------------------------//
function hscr_start_input_lockout(){

	_ct_input_lockout = 15;
	_flag_clicked = true;
	_ct_cooldown = _ct_input_lockout;
}

//—------------------------------------------------------------------------------//
// hscr_update_input_lockout
// FUNCTION: Updates inventory input lockout timer.
//—------------------------------------------------------------------------------//
function hscr_update_input_lockout(){

	if (_ct_input_lockout > 0){
		_ct_input_lockout--;
	}
}

//—------------------------------------------------------------------------------//
// hscr_can_accept_input
// FUNCTION: Returns whether inventory can currently process clicks.
//—------------------------------------------------------------------------------//
function hscr_can_accept_input(){

	if (_flag_prompt_active){
		return false;
	}

	if (_ct_input_lockout > 0){
		return false;
	}

	return true;
}

//—------------------------------------------------------------------------------//
// hscr_open_item_prompt
// FUNCTION: Opens an item-use prompt for supported inventory item types.
//           Supports prism and egg behavior.
//           Other item types are ignored for now.
//—------------------------------------------------------------------------------//
function hscr_open_item_prompt(_stct_item){

	if (_flag_prompt_active){
		return;
	}

	if (_stct_item == undefined){
		return;
	}

	var _scr_yes_callback = undefined;

	show_debug_message("ITEM CLICKED: " + string(_stct_item._str_item_name) + " | TYPE: " + string(_stct_item._str_item_type));

	switch(_stct_item._str_item_type){

		case "PRISM":
			_scr_yes_callback = scr_inventory_use_prism_item_ow;
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

//—------------------------------------------------------------------------------//
// hscr_update_click_cooldown
// FUNCTION: Updates inventory click cooldown.
//           Prevents repeated item prompt openings from one input.
//
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

//—------------------------------------------------------------------------------//
// hscr_mark_inventory_dirty
// FUNCTION: Marks the cached inventory display list for rebuilding.
//—------------------------------------------------------------------------------//
function hscr_mark_inventory_dirty(){
	_flag_inventory_dirty = true;
}

//—------------------------------------------------------------------------------//
// hscr_refresh_inventory_cache
// FUNCTION: Rebuilds the cached filtered/sorted inventory list only when needed.
//           Refreshes pagination data after sort, filter, or inventory changes.
//—------------------------------------------------------------------------------//
function hscr_refresh_inventory_cache(){

	if (!_flag_inventory_dirty && _ct_inventory_seen_revision == global.ct_inventory_revision){
		return;
	}

	ds_list_clear(_list_filtered_inventory);

	var _list_new = hscr_build_filtered_inventory();

	hscr_sort_inventory(_list_new);

	for (var _it_item = 0; _it_item < ds_list_size(_list_new); _it_item++){
		var _stct_item = ds_list_find_value(_list_new,_it_item);
		ds_list_add(_list_filtered_inventory,_stct_item);
	}

	ds_list_destroy(_list_new);

	_ct_inventory_filtered = ds_list_size(_list_filtered_inventory);
	_ct_inventory_total_pages = max(1,ceil(_ct_inventory_filtered / _ct_inventory_per_page));

	_ct_inventory_page = clamp(_ct_inventory_page,0,_ct_inventory_total_pages - 1);

	_ct_inventory_seen_revision = global.ct_inventory_revision;
	_flag_inventory_dirty = false;
}

//—------------------------------------------------------------------------------//
// hscr_build_filtered_inventory
// FUNCTION: Builds a temporary filtered inventory list.
//           Reads inventory backward when sorting by recent.
//—------------------------------------------------------------------------------//
function hscr_build_filtered_inventory(){
	var _list_filtered = ds_list_create();

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
	} else {
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

//—------------------------------------------------------------------------------//
// hscr_get_item_type_order
// FUNCTION: Returns sort order value for item type.
//—------------------------------------------------------------------------------//
function hscr_get_item_type_order(_str_item_type){
	switch(_str_item_type){
		case "CONSUMABLE": return 0;
		case "EGG": return 1;
		case "HELD": return 2;
		case "PRISM": return 3;
		case "QUEST": return 4;
	}

	return 99;
}

//—------------------------------------------------------------------------------//
// hscr_sort_inventory
// FUNCTION: Sorts a temporary inventory list by current sort mode.
//—------------------------------------------------------------------------------//
function hscr_sort_inventory(_list_filtered){
	var _ct_filtered = ds_list_size(_list_filtered);

	for (var _it_a = 0; _it_a < _ct_filtered - 1; _it_a++){
		for (var _it_b = _it_a + 1; _it_b < _ct_filtered; _it_b++){
			var _stct_a = ds_list_find_value(_list_filtered,_it_a);
			var _stct_b = ds_list_find_value(_list_filtered,_it_b);

			var _flag_swap = false;

			switch(_str_sort_mode){
				case "ALPHABETICAL":
					_flag_swap = string_lower(_stct_a._str_item_name) > string_lower(_stct_b._str_item_name);
				break;

				case "TYPE":
					_flag_swap = hscr_get_item_type_order(_stct_a._str_item_type) > hscr_get_item_type_order(_stct_b._str_item_type);
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

//—------------------------------------------------------------------------------//
// hscr_get_item_type_color
// FUNCTION: Returns display color for an item type.
//—------------------------------------------------------------------------------//
function hscr_get_item_type_color(_str_item_type){
	switch(_str_item_type){
		case "QUEST": return c_yellow;
		case "CONSUMABLE": return c_green;
		case "PRISM": return c_aqua;
		case "HELD": return make_colour_rgb(255,140,0);
		case "EGG": return make_colour_rgb(180,100,255);
	}

	return c_gray;
}

//—------------------------------------------------------------------------------//
// hscr_update_layout
// FUNCTION: Recalculates slot layout values.
//—------------------------------------------------------------------------------//
function hscr_update_layout(){
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

//—------------------------------------------------------------------------------//
// hscr_draw_inventory_slots
// FUNCTION: Draws visible inventory item slots.
//—------------------------------------------------------------------------------//
function hscr_draw_inventory_slots(_list_filtered){
	var _ct_filtered = ds_list_size(_list_filtered);
	var _ct_start_index = _ct_inventory_page * _ct_inventory_per_page;
	var _val_box_x = _val_inventory_x;

	for (var _it_slot = 0; _it_slot < _ct_inventory_per_page; _it_slot++){
		var _it_item = _ct_start_index + _it_slot;

		if (_it_item >= _ct_filtered){
			break;
		}

		var _stct_item = ds_list_find_value(_list_filtered,_it_item);
		var _val_box_y = _val_start_y + _it_slot * (_val_slot_h + _val_slot_spacing);
		var _c_slot = hscr_get_item_type_color(_stct_item._str_item_type);

		draw_set_colour(c_black);
		draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,false);

		draw_set_colour(_c_slot);
		draw_rectangle(_val_box_x + 2,_val_box_y + 2,_val_box_x + _val_slot_w - 2,_val_box_y + _val_slot_h - 2,false);

		draw_sprite_ext(_stct_item._spr_item,0,_val_box_x + 20,_val_box_y + (_val_slot_h * 0.5),1,1,0,c_white,1);

		draw_set_colour(c_black);

		var _str_item_text = _stct_item._str_item_name;

		if (_stct_item._flag_stackable){
			_str_item_text += " x" + string(_stct_item._ct_item_amount);
		}

		draw_text(_val_box_x + 60,_val_box_y + 28,_str_item_text);

		var _flag_hover = device_mouse_x_to_gui(0) > _val_box_x && device_mouse_x_to_gui(0) < _val_box_x + _val_slot_w && device_mouse_y_to_gui(0) > _val_box_y && device_mouse_y_to_gui(0) < _val_box_y + _val_slot_h;

		if (_flag_hover && hscr_can_accept_input()){

			draw_set_colour(c_white);
			draw_rectangle(_val_box_x - 2,_val_box_y - 2,_val_box_x + _val_slot_w + 2,_val_box_y + _val_slot_h + 2,true);

			if (keyboard_check(vk_lcontrol)){
				_stct_preview_item = _stct_item;
			}

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
				_flag_clicked = true;
				_ct_cooldown = 10;

				hscr_open_item_prompt(_stct_item);
			}
		}
	}
}

//—------------------------------------------------------------------------------//
// hscr_draw_page_text
// FUNCTION: Draws current inventory page text.
//—------------------------------------------------------------------------------//
function hscr_draw_page_text(_ct_total_pages){
	draw_set_colour(c_black);
	draw_set_halign(fa_center);
	draw_text(_val_page_center_x,_val_page_y,"PAGE " + string(_ct_inventory_page + 1) + "/" + string(_ct_total_pages));
	draw_set_halign(fa_left);
}

//—------------------------------------------------------------------------------//
// hscr_handle_sort_filter_input
// FUNCTION: Handles sort and filter button clicks before inventory list is built.
//—------------------------------------------------------------------------------//
function hscr_handle_sort_filter_input(){
	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _val_sort_x = _val_pane_left + 20;
	var _val_sort_y = _val_pane_top + _val_pane_h - 70;
	var _val_filter_x = _val_pane_left + _val_pane_w - 220;
	var _val_filter_y = _val_sort_y;

	var _flag_sort_hover = _val_mouse_x > _val_sort_x && _val_mouse_x < _val_sort_x + 200 && _val_mouse_y > _val_sort_y && _val_mouse_y < _val_sort_y + 25;
	var _flag_filter_hover = _val_mouse_x > _val_filter_x && _val_mouse_x < _val_filter_x + 200 && _val_mouse_y > _val_filter_y && _val_mouse_y < _val_filter_y + 25;

	if (mouse_check_button_pressed(mb_left)){
		if (_flag_sort_hover){
			switch(_str_sort_mode){
				case "RECENT": _str_sort_mode = "TYPE"; break;
				case "TYPE": _str_sort_mode = "ALPHABETICAL"; break;
				case "ALPHABETICAL": _str_sort_mode = "RECENT"; break;
			}

			_ct_inventory_page = 0;
			hscr_mark_inventory_dirty();
		}

		if (_flag_filter_hover){
			switch(_str_filter_mode){
				case "ALL": _str_filter_mode = "CONSUMABLE"; break;
				case "CONSUMABLE": _str_filter_mode = "EGG"; break;
				case "EGG": _str_filter_mode = "HELD"; break;
				case "HELD": _str_filter_mode = "PRISM"; break;
				case "PRISM": _str_filter_mode = "QUEST"; break;
				case "QUEST": _str_filter_mode = "ALL"; break;
			}

			_ct_inventory_page = 0;
			hscr_mark_inventory_dirty();
		}
	}
}

//—------------------------------------------------------------------------------//
// hscr_draw_sort_filter_buttons
// FUNCTION: Draws sort and filter buttons.
//—------------------------------------------------------------------------------//
function hscr_draw_sort_filter_buttons(){
	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _val_sort_x = _val_pane_left + 20;
	var _val_sort_y = _val_pane_top + _val_pane_h - 70;

	var _flag_sort_hover = _val_mouse_x > _val_sort_x && _val_mouse_x < _val_sort_x + 200 && _val_mouse_y > _val_sort_y && _val_mouse_y < _val_sort_y + 25;

	draw_set_colour(_flag_sort_hover ? c_white : c_gray);
	draw_rectangle(_val_sort_x,_val_sort_y,_val_sort_x + 200,_val_sort_y + 25,false);

	draw_set_colour(c_black);
	draw_text(_val_sort_x + 5,_val_sort_y + 5,"SORT: " + _str_sort_mode);

	var _val_filter_x = _val_pane_left + _val_pane_w - 220;
	var _val_filter_y = _val_sort_y;

	var _flag_filter_hover = _val_mouse_x > _val_filter_x && _val_mouse_x < _val_filter_x + 200 && _val_mouse_y > _val_filter_y && _val_mouse_y < _val_filter_y + 25;

	draw_set_colour(_flag_filter_hover ? c_white : c_gray);
	draw_rectangle(_val_filter_x,_val_filter_y,_val_filter_x + 200,_val_filter_y + 25,false);

	draw_set_colour(c_black);
	draw_text(_val_filter_x + 5,_val_filter_y + 5,"FILTER: " + _str_filter_mode);
}

//—------------------------------------------------------------------------------//
// hscr_draw_preview_modal
// FUNCTION: Draws held-control item preview modal.
//—------------------------------------------------------------------------------//
function hscr_draw_preview_modal(){
	if (_stct_preview_item != undefined && keyboard_check(vk_lcontrol)){
		var _val_center_x = display_get_gui_width() * 0.5;
		var _val_center_y = display_get_gui_height() * 0.5;

		draw_set_colour(c_black);
		draw_rectangle(_val_center_x - 300,_val_center_y - 300,_val_center_x + 300,_val_center_y + 300,false);

		draw_sprite_ext(_stct_preview_item._spr_item,0,_val_center_x,_val_center_y - 40,_val_preview_scale,_val_preview_scale,0,c_white,1);

		draw_set_colour(c_white);
		draw_text(_val_center_x - 120,_val_center_y + 80,_stct_preview_item._str_item_name);

		draw_set_colour(c_ltgray);
		draw_text_ext(_val_center_x - 120,_val_center_y + 100,_stct_preview_item._str_item_desc,16,300);
	}
}

#endregion