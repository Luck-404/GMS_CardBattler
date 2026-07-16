//===============================================================================//
//
// CREATE: OBJ_GUI_LOGBOOK_PANE
// FUNCTION: Initializes the logbook GUI shell.
//           Stores beast/card mode, paging, selection, and layout values.
//           Defines object-local helper scripts used by the Draw GUI event.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -1;

_str_type = "LOGBOOK";

_str_logbook_mode = "BEAST"; // BEAST, CARD

_ct_logbook_page = 0;
_ct_entries_per_page = 15;

_str_entry_selected_id = "";

_val_pane_w = 800;
_val_pane_h = 800;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_list_x = _val_pane_left + 20;
_val_detail_x = _val_pane_left + 420;

_val_start_y = _val_pane_top + 80;

_val_slot_w = 360;
_val_slot_h = 32;
_val_slot_gap = 4;

_val_detail_w = 360;

_val_page_y = _val_pane_top + _val_pane_h - 42;
_val_page_center_x = _val_list_x + (_val_slot_w * 0.5);
_val_arrow_offset = 80;

_flag_clicked = false;
_ct_cooldown = 0;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_get_active_list
// FUNCTION: Returns the active logbook list based on current mode.
//—------------------------------------------------------------------------------//
hscr_get_active_list = function(){

	if (_str_logbook_mode == "BEAST"){
		return global.list_logbook_beasts;
	}

	return global.list_logbook_cards;
};

//—------------------------------------------------------------------------------//
// hscr_get_entry_id
// FUNCTION: Returns the id field for a beast or card logbook entry.
//—------------------------------------------------------------------------------//
hscr_get_entry_id = function(_stct_entry){

	if (_stct_entry == undefined){
		return "";
	}

	if (_str_logbook_mode == "BEAST"){
		return _stct_entry._str_beast_id;
	}

	return _stct_entry._str_card_id;
};

//—------------------------------------------------------------------------------//
// hscr_get_entry_name
// FUNCTION: Returns the display name for a beast or card logbook entry.
//—------------------------------------------------------------------------------//
hscr_get_entry_name = function(_stct_entry){

	if (_stct_entry == undefined){
		return "UNKNOWN";
	}

	if (_str_logbook_mode == "BEAST"){
		return _stct_entry._str_beast_name;
	}

	return _stct_entry._str_card_name;
};

//—------------------------------------------------------------------------------//
// hscr_get_total_pages
// FUNCTION: Returns the total page count for the current logbook mode.
//—------------------------------------------------------------------------------//
hscr_get_total_pages = function(){

	var _list_entries = hscr_get_active_list();
	var _ct_entries = ds_list_size(_list_entries);

	if (_ct_entries <= 0){
		return 1;
	}

	return max(1,ceil(_ct_entries / _ct_entries_per_page));
};

//—------------------------------------------------------------------------------//
// hscr_get_entry_at_slot
// FUNCTION: Returns the logbook entry displayed in a visible row slot.
//—------------------------------------------------------------------------------//
hscr_get_entry_at_slot = function(_it_slot){

	var _list_entries = hscr_get_active_list();
	var _it_entry = (_ct_logbook_page * _ct_entries_per_page) + _it_slot;

	if (_it_entry < 0 || _it_entry >= ds_list_size(_list_entries)){
		return undefined;
	}

	return ds_list_find_value(_list_entries,_it_entry);
};

//—------------------------------------------------------------------------------//
// hscr_set_default_selection
// FUNCTION: Selects the first entry on the current page if nothing is selected.
//—------------------------------------------------------------------------------//
hscr_set_default_selection = function(){

	if (_str_entry_selected_id != ""){
		return;
	}

	var _stct_entry = hscr_get_entry_at_slot(0);

	if (_stct_entry != undefined){
		_str_entry_selected_id = hscr_get_entry_id(_stct_entry);
	}
};

//—------------------------------------------------------------------------------//
// hscr_get_selected_entry
// FUNCTION: Returns the currently selected logbook entry from the active map.
//—------------------------------------------------------------------------------//
hscr_get_selected_entry = function(){

	if (_str_entry_selected_id == ""){
		return undefined;
	}

	if (_str_logbook_mode == "BEAST"){

		if (ds_map_exists(global.map_logbook_beasts,_str_entry_selected_id)){
			return global.map_logbook_beasts[? _str_entry_selected_id];
		}
	}
	else{

		if (ds_map_exists(global.map_logbook_cards,_str_entry_selected_id)){
			return global.map_logbook_cards[? _str_entry_selected_id];
		}
	}

	return undefined;
};

//—------------------------------------------------------------------------------//
// hscr_array_to_text
// FUNCTION: Converts an array into readable display text.
//           Skips undefined values.
//—------------------------------------------------------------------------------//
hscr_array_to_text = function(_arr_data,_str_separator){

	if (!is_array(_arr_data)){
		return string(_arr_data);
	}

	var _str_text = "";

	for (var _it_value = 0; _it_value < array_length(_arr_data); _it_value++){

		var _val_data = _arr_data[_it_value];

		if (_val_data == undefined){
			continue;
		}

		if (_str_text != ""){
			_str_text += _str_separator;
		}

		_str_text += string(_val_data);
	}

	if (_str_text == ""){
		return "UNKNOWN";
	}

	return _str_text;
};

//—------------------------------------------------------------------------------//
// hscr_is_mouse_in_rect
// FUNCTION: Returns whether the GUI mouse is inside a rectangle.
//—------------------------------------------------------------------------------//
hscr_is_mouse_in_rect = function(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2){

	return (
		_val_mouse_x >= _val_x1 &&
		_val_mouse_x <= _val_x2 &&
		_val_mouse_y >= _val_y1 &&
		_val_mouse_y <= _val_y2
	);
};

//—------------------------------------------------------------------------------//
// hscr_update_click_cooldown
// FUNCTION: Updates the shared click cooldown.
//—------------------------------------------------------------------------------//
hscr_update_click_cooldown = function(){

	if (_flag_clicked){

		if (_ct_cooldown > 0){
			_ct_cooldown--;
		}
		else{
			_ct_cooldown = 0;
			_flag_clicked = false;
		}
	}
};

//—------------------------------------------------------------------------------//
// hscr_handle_mode_and_page_input
// FUNCTION: Handles tab mode switching and keyboard page navigation.
//—------------------------------------------------------------------------------//
hscr_handle_mode_and_page_input = function(){

	var _ct_total_pages = hscr_get_total_pages();

	// SWITCH BEAST / CARD MODE
	if (keyboard_check_pressed(vk_tab)){

		if (_str_logbook_mode == "BEAST"){
			_str_logbook_mode = "CARD";
		}
		else{
			_str_logbook_mode = "BEAST";
		}

		_ct_logbook_page = 0;
		_str_entry_selected_id = "";
	}

	// PREVIOUS PAGE
	if (keyboard_check_pressed(vk_left)){
		audio_play_sound(snd_gui_press,0,false);
		if (_ct_logbook_page > 0){
			_ct_logbook_page--;
			_str_entry_selected_id = "";
		}
	}

	// NEXT PAGE
	if (keyboard_check_pressed(vk_right)){
		audio_play_sound(snd_gui_press,0,false);
		if (_ct_logbook_page < _ct_total_pages - 1){
			_ct_logbook_page++;
			_str_entry_selected_id = "";
		}
	}

	hscr_set_default_selection();
};

//—------------------------------------------------------------------------------//
// hscr_draw_entry_row
// FUNCTION: Draws one beast/card logbook row.
//           Handles row selection by mouse click.
//—------------------------------------------------------------------------------//
hscr_draw_entry_row = function(_stct_entry,_it_slot,_val_mouse_x,_val_mouse_y){

	if (_stct_entry == undefined){
		return;
	}

	var _val_box_x = _val_list_x;
	var _val_box_y = _val_start_y + (_it_slot * (_val_slot_h + _val_slot_gap));

	var _str_entry_id = hscr_get_entry_id(_stct_entry);
	var _str_entry_name = hscr_get_entry_name(_stct_entry);

	var _flag_selected = (_str_entry_id == _str_entry_selected_id);
	var _flag_hover = hscr_is_mouse_in_rect(
		_val_mouse_x,
		_val_mouse_y,
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h
	);

	// ROW BOX
	draw_set_colour(c_black);
	draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,false);

	if (_flag_selected){
		draw_set_colour(c_dkgray);
	}
	else if (_flag_hover){
		draw_set_colour(global.c_dk_gray);
	}
	else{
		draw_set_colour(c_ltgray);
	}

	draw_rectangle(_val_box_x + 2,_val_box_y + 2,_val_box_x + _val_slot_w - 2,_val_box_y + _val_slot_h - 2,false);

	// CLICK SELECT
	if (_flag_hover && mouse_check_button_pressed(mb_left) && !_flag_clicked){
		audio_play_sound(snd_gui_press,0,false);
		_flag_clicked = true;
		_ct_cooldown = 10;
		_str_entry_selected_id = _str_entry_id;
	}

	// STATUS TEXT
	var _str_status = "";
	var _ct_owned = 0;
	var _c_text = c_black;

	if (_str_logbook_mode == "BEAST"){

		_ct_owned = scr_logbook_get_beast_owned_count(_str_entry_id);

		if (_stct_entry._flag_captured){
			_str_status = "✓";
			_c_text = c_green;
		}
		else if (_stct_entry._flag_seen){
			_str_status = "•";
			_c_text = c_black;
		}
		else{
			_str_status = "-";
			_c_text = c_dkgray;
		}
	}
	else{

		_ct_owned = scr_logbook_get_card_owned_count(_str_entry_id);

		if (_stct_entry._flag_obtained){
			_str_status = "✓";
			_c_text = c_green;
		}
		else if (_stct_entry._flag_seen){
			_str_status = "•";
			_c_text = c_black;
		}
		else{
			_str_status = "-";
			_c_text = c_dkgray;
		}
	}

	draw_set_colour(_c_text);
	draw_text(_val_box_x + 10,_val_box_y + 8,_str_status + " " + _str_entry_name);

	draw_set_colour(c_black);
	draw_text(_val_box_x + _val_slot_w - 58,_val_box_y + 8,"x" + string(_ct_owned));
};

//—------------------------------------------------------------------------------//
// hscr_draw_beast_details
// FUNCTION: Draws selected beast logbook details.
//—------------------------------------------------------------------------------//
hscr_draw_beast_details = function(_stct_entry){

	var _val_text_x = _val_detail_x;
	var _val_text_y = _val_start_y;
	var _val_lh = 22;

	draw_set_colour(c_white);
	draw_set_font(fnt_medium_gui);
	draw_text(_val_text_x,_val_text_y,_stct_entry._str_beast_name);

	draw_set_font(fnt_small_gui);
	_val_text_y += _val_lh * 2;

	var _ct_owned = scr_logbook_get_beast_owned_count(_stct_entry._str_beast_id);

	draw_text(_val_text_x,_val_text_y,"COLOR: " + string(_stct_entry._str_color_group));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"SEEN: " + string(_stct_entry._flag_seen));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"CAPTURED: " + string(_stct_entry._flag_captured));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"OWNED: " + string(_ct_owned));
	_val_text_y += _val_lh * 2;

	// NOT SEEN
	if (!_stct_entry._flag_seen){
		draw_set_colour(c_ltgray);
		draw_text_ext(_val_text_x,_val_text_y,"NO DATA. Encounter this beast to reveal basic information.",-1,_val_detail_w);
		return;
	}

	// BASE DATA MISSING
	if (!_stct_entry._flag_has_beast_info || _stct_entry._stct_beast_info == undefined){
		draw_set_colour(c_ltgray);
		draw_text_ext(_val_text_x,_val_text_y,"BASE BEAST DATA NOT IMPLEMENTED YET.",-1,_val_detail_w);
		return;
	}

	var _stct_beast = _stct_entry._stct_beast_info;

	// BASIC SEEN DATA
	draw_sprite_ext(_stct_beast._spr_beast,0,_val_text_x + 170,_val_text_y + 350,0.25,0.25,0,c_white,1);

	draw_set_colour(c_white);
	draw_text(_val_text_x,_val_text_y,"ARCHETYPE: " + string(_stct_beast._str_beast_archetype));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"CLASS: " + string(_stct_beast._str_beast_class));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"TYPES: " + hscr_array_to_text(_stct_beast._str_beast_color_type," / "));
	_val_text_y += _val_lh * 2;

	// CAPTURE-LOCKED DATA
	if (!_stct_entry._flag_captured){
		draw_set_colour(c_ltgray);
		draw_text_ext(_val_text_x,_val_text_y,"CAPTURE THIS BEAST TO REVEAL FULL STATS, ABILITIES, ROLE, AND LORE.",-1,_val_detail_w);
		return;
	}

	// FULL CAPTURED DATA
	draw_set_colour(c_white);

	draw_text(_val_text_x,_val_text_y,"HP: " + string(_stct_beast._val_beast_hp_stat) + " (" + scr_get_beast_grade_letter(_stct_beast._val_beast_hp_stat) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"PPOW: " + string(_stct_beast._val_beast_ppow_stat) + " (" + scr_get_beast_grade_letter(_stct_beast._val_beast_ppow_stat) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MPOW: " + string(_stct_beast._val_beast_mpow_stat) + " (" + scr_get_beast_grade_letter(_stct_beast._val_beast_mpow_stat) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"PDEF: " + string(_stct_beast._val_beast_pdef_stat) + " (" + scr_get_beast_grade_letter(_stct_beast._val_beast_pdef_stat) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MDEF: " + string(_stct_beast._val_beast_mdef_stat) + " (" + scr_get_beast_grade_letter(_stct_beast._val_beast_mdef_stat) + ")");
	_val_text_y += _val_lh * 2;

	draw_text_ext(_val_text_x,_val_text_y,_stct_beast._str_beast_role,-1,_val_detail_w);
};

//—------------------------------------------------------------------------------//
// hscr_draw_card_details
// FUNCTION: Draws selected card logbook details.
//—------------------------------------------------------------------------------//
hscr_draw_card_details = function(_stct_entry){

	var _val_text_x = _val_detail_x;
	var _val_text_y = _val_start_y;
	var _val_lh = 22;

	draw_set_colour(c_white);
	draw_set_font(fnt_medium_gui);
	draw_text(_val_text_x,_val_text_y,_stct_entry._str_card_name);

	draw_set_font(fnt_small_gui);
	_val_text_y += _val_lh * 2;

	var _ct_owned = scr_logbook_get_card_owned_count(_stct_entry._str_card_id);

	draw_text(_val_text_x,_val_text_y,"COLOR: " + string(_stct_entry._str_color_group));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"SEEN: " + string(_stct_entry._flag_seen));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"OBTAINED: " + string(_stct_entry._flag_obtained));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"OWNED: " + string(_ct_owned));
	_val_text_y += _val_lh * 2;

	// NOT SEEN
	if (!_stct_entry._flag_seen){
		draw_set_colour(c_ltgray);
		draw_text_ext(_val_text_x,_val_text_y,"NO DATA. Find this card to reveal its information.",-1,_val_detail_w);
		return;
	}

	// BASE DATA MISSING
	if (!_stct_entry._flag_has_card_info || _stct_entry._stct_card_info == undefined){
		draw_set_colour(c_ltgray);
		draw_text_ext(_val_text_x,_val_text_y,"BASE CARD DATA NOT IMPLEMENTED YET.",-1,_val_detail_w);
		return;
	}

	var _stct_card = _stct_entry._stct_card_info;

	draw_sprite_ext(_stct_card._spr_card,0,_val_text_x + 170,_val_text_y + 350,0.45,0.45,0,c_white,1);

	draw_set_colour(c_white);

	draw_text(_val_text_x,_val_text_y,"TYPE: " + string(_stct_card._str_card_type));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"RANGE: " + string(_stct_card._str_card_range));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"RARITY: " + string(_stct_card._str_card_rarity));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MANA: " + string(_stct_card._val_card_mana_cost));
	_val_text_y += _val_lh * 2;

	draw_text_ext(_val_text_x,_val_text_y,_stct_card._str_card_description,-1,_val_detail_w);
};

//—------------------------------------------------------------------------------//
// hscr_draw_selected_details
// FUNCTION: Draws the selected beast or card detail pane.
//—------------------------------------------------------------------------------//
hscr_draw_selected_details = function(){

	var _stct_entry = hscr_get_selected_entry();

	if (_stct_entry == undefined){
		draw_set_colour(c_white);
		draw_text(_val_detail_x,_val_start_y,"NO ENTRY SELECTED");
		return;
	}

	if (_str_logbook_mode == "BEAST"){
		hscr_draw_beast_details(_stct_entry);
	}
	else{
		hscr_draw_card_details(_stct_entry);
	}
};

#endregion