//===============================================================================//
//
// CREATE: OBJ_GUI_LOGBOOK_PANE
// FUNCTION: Initializes the logbook GUI shell.
//           Stores Beast/card mode, paging, selection, and layout values.
//           Defines object-local helpers used by the Draw GUI event.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
_str_type = "LOGBOOK";

_str_logbook_mode = "BEAST";

_it_logbook_page = 0;
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

//================//
//INIT//
//================//
depth = -1;

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_GET_ACTIVE_LIST
// FUNCTION: Returns the active logbook list based on the current mode.
//
// ARGUMENTS: None.
// RETURNS: Active Beast or card logbook DS list.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_get_active_list = function(){

	if (_str_logbook_mode == "BEAST"){
		return global.list_logbook_beasts;
	}

	return global.list_logbook_cards;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_GET_ENTRY_ID
// FUNCTION: Returns the id field for a Beast or card logbook entry.
//
// ARGUMENTS: _stct_entry is the logbook entry.
// RETURNS: Entry id string, or an empty string when invalid.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_get_entry_id = function(_stct_entry){

	if (_stct_entry == undefined){
		return "";
	}

	if (_str_logbook_mode == "BEAST"){
		return _stct_entry._str_beast_id;
	}

	return _stct_entry._str_card_id;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_GET_ENTRY_NAME
// FUNCTION: Returns the display name for a Beast or card logbook entry.
//
// ARGUMENTS: _stct_entry is the logbook entry.
// RETURNS: Entry display name, or UNKNOWN when invalid.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_get_entry_name = function(_stct_entry){

	if (_stct_entry == undefined){
		return "UNKNOWN";
	}

	if (_str_logbook_mode == "BEAST"){
		return _stct_entry._str_beast_name;
	}

	return _stct_entry._str_card_name;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_GET_TOTAL_PAGES
// FUNCTION: Returns the total page count for the current logbook mode.
//
// ARGUMENTS: None.
// RETURNS: Total number of logbook pages.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_get_total_pages = function(){

	var _list_entries = hscr_gui_logbook_get_active_list();
	var _ct_entries = ds_list_size(_list_entries);

	if (_ct_entries <= 0){
		return 1;
	}

	return max(1,ceil(_ct_entries / _ct_entries_per_page));
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_GET_ENTRY_AT_SLOT
// FUNCTION: Returns the logbook entry displayed in a visible row slot.
//
// ARGUMENTS: _it_slot is the visible zero-based row slot.
// RETURNS: Logbook entry struct, or undefined when outside the active list.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_get_entry_at_slot = function(_it_slot){

	var _list_entries = hscr_gui_logbook_get_active_list();
	var _it_entry = (_it_logbook_page * _ct_entries_per_page) + _it_slot;

	if (_it_entry < 0 || _it_entry >= ds_list_size(_list_entries)){
		return undefined;
	}

	return ds_list_find_value(_list_entries,_it_entry);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_SET_DEFAULT_SELECTION
// FUNCTION: Selects the first entry on the current page when nothing is selected.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_set_default_selection = function(){

	if (_str_entry_selected_id != ""){
		return;
	}

	var _stct_entry = hscr_gui_logbook_get_entry_at_slot(0);

	if (_stct_entry != undefined){
		_str_entry_selected_id = hscr_gui_logbook_get_entry_id(_stct_entry);
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_GET_SELECTED_ENTRY
// FUNCTION: Returns the currently selected entry from the active logbook map.
//
// ARGUMENTS: None.
// RETURNS: Selected logbook entry struct, or undefined when unavailable.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_get_selected_entry = function(){

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

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_ARRAY_TO_TEXT
// FUNCTION: Converts an array into readable display text.
//           Skips undefined values.
//
// ARGUMENTS: _arr_data is the source array; _str_separator joins values.
// RETURNS: Formatted text or UNKNOWN when no usable values exist.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_array_to_text = function(_arr_data,_str_separator){

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

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_IS_MOUSE_IN_RECT
// FUNCTION: Checks whether the GUI mouse position is inside a rectangle.
//
// ARGUMENTS: Mouse x/y and rectangle x1/y1/x2/y2 coordinates.
// RETURNS: True when the mouse is inside the rectangle.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_is_mouse_in_rect = function(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2){

	return (
		_val_mouse_x >= _val_x1 &&
		_val_mouse_x <= _val_x2 &&
		_val_mouse_y >= _val_y1 &&
		_val_mouse_y <= _val_y2
	);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_UPDATE_CLICK_COOLDOWN
// FUNCTION: Updates the shared logbook click cooldown.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_update_click_cooldown = function(){

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

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_HANDLE_MODE_AND_PAGE_INPUT
// FUNCTION: Handles tab mode switching and keyboard page navigation.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_handle_mode_and_page_input = function(){

	var _ct_total_pages = hscr_gui_logbook_get_total_pages();

	//----------------//
	//SWITCH MODE//
	//----------------//
	if (keyboard_check_pressed(vk_tab)){

		if (_str_logbook_mode == "BEAST"){
			_str_logbook_mode = "CARD";
		}
		else{
			_str_logbook_mode = "BEAST";
		}

		_it_logbook_page = 0;
		_str_entry_selected_id = "";
	}

	//----------------//
	//PREVIOUS PAGE//
	//----------------//
	if (keyboard_check_pressed(vk_left)){

		audio_play_sound(snd_gui_press,0,false);

		if (_it_logbook_page > 0){
			_it_logbook_page--;
			_str_entry_selected_id = "";
		}
	}

	//----------------//
	//NEXT PAGE//
	//----------------//
	if (keyboard_check_pressed(vk_right)){

		audio_play_sound(snd_gui_press,0,false);

		if (_it_logbook_page < _ct_total_pages - 1){
			_it_logbook_page++;
			_str_entry_selected_id = "";
		}
	}

	hscr_gui_logbook_set_default_selection();
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_DRAW_ENTRY_ROW
// FUNCTION: Draws one Beast/card logbook row.
//           Handles row selection by mouse click.
//
// ARGUMENTS: Entry struct, row slot, and GUI mouse x/y.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_draw_entry_row = function(_stct_entry,_it_slot,_val_mouse_x,_val_mouse_y){

	if (_stct_entry == undefined){
		return;
	}

	var _val_box_x = _val_list_x;
	var _val_box_y = _val_start_y + (_it_slot * (_val_slot_h + _val_slot_gap));

	var _str_entry_id = hscr_gui_logbook_get_entry_id(_stct_entry);
	var _str_entry_name = hscr_gui_logbook_get_entry_name(_stct_entry);

	var _flag_selected = (_str_entry_id == _str_entry_selected_id);

	var _flag_hover = hscr_gui_logbook_is_mouse_in_rect(
		_val_mouse_x,
		_val_mouse_y,
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h
	);

	//----------------//
	//DRAW ROW//
	//----------------//
	draw_set_colour(c_black);
	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h,
		false
	);

	if (_flag_selected){
		draw_set_colour(global.c_dk_gray);
	}
	else if (_flag_hover){
		draw_set_colour(global.c_dk_gray);
	}
	else{
		draw_set_colour(c_ltgray);
	}

	draw_rectangle(
		_val_box_x + 2,
		_val_box_y + 2,
		_val_box_x + _val_slot_w - 2,
		_val_box_y + _val_slot_h - 2,
		false
	);

	//----------------//
	//SELECT ROW//
	//----------------//
	if (_flag_hover && mouse_check_button_pressed(mb_left) && !_flag_clicked){

		audio_play_sound(snd_gui_press,0,false);

		_flag_clicked = true;
		_ct_cooldown = 10;
		_str_entry_selected_id = _str_entry_id;
	}

	//----------------//
	//GET STATUS//
	//----------------//
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
			_c_text = global.c_dk_gray;
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
			_c_text = global.c_dk_gray;
		}
	}

	//----------------//
	//DRAW STATUS//
	//----------------//
	draw_set_colour(_c_text);
	draw_text(
		_val_box_x + 10,
		_val_box_y + 8,
		_str_status + " " + _str_entry_name
	);

	draw_set_colour(c_black);
	draw_text(
		_val_box_x + _val_slot_w - 58,
		_val_box_y + 8,
		"x" + string(_ct_owned)
	);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_DRAW_BEAST_DETAILS
// FUNCTION: Draws the selected Beast logbook details.
//           Reveals additional information after seeing and capturing the Beast.
//
// ARGUMENTS: _stct_entry is the selected Beast logbook entry.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_draw_beast_details = function(_stct_entry){

	var _val_text_x = _val_detail_x;
	var _val_text_y = _val_start_y;
	var _val_line_height = 22;

	//----------------//
	//HEADER//
	//----------------//
	draw_set_colour(c_white);
	draw_set_font(fnt_gui_medium);
	draw_text(_val_text_x,_val_text_y,_stct_entry._str_beast_name);

	draw_set_font(fnt_gui_small);
	_val_text_y += _val_line_height * 2;

	var _ct_owned = scr_logbook_get_beast_owned_count(_stct_entry._str_beast_id);

	draw_text(_val_text_x,_val_text_y,"COLOR: " + string(_stct_entry._str_color_group));
	_val_text_y += _val_line_height;

	draw_text(_val_text_x,_val_text_y,"SEEN: " + string(_stct_entry._flag_seen));
	_val_text_y += _val_line_height;

	draw_text(_val_text_x,_val_text_y,"CAPTURED: " + string(_stct_entry._flag_captured));
	_val_text_y += _val_line_height;

	draw_text(_val_text_x,_val_text_y,"OWNED: " + string(_ct_owned));
	_val_text_y += _val_line_height * 2;

	//----------------//
	//NOT SEEN//
	//----------------//
	if (!_stct_entry._flag_seen){

		draw_set_colour(c_ltgray);

		draw_text_ext(
			_val_text_x,
			_val_text_y,
			"NO DATA. Encounter this Beast to reveal basic information.",
			-1,
			_val_detail_w
		);

		return;
	}

	//----------------//
	//MISSING BASE DATA//
	//----------------//
	if (!_stct_entry._flag_has_beast_info || _stct_entry._stct_beast_info == undefined){

		draw_set_colour(c_ltgray);

		draw_text_ext(
			_val_text_x,
			_val_text_y,
			"BASE BEAST DATA NOT IMPLEMENTED YET.",
			-1,
			_val_detail_w
		);

		return;
	}

	var _stct_beast = _stct_entry._stct_beast_info;

	//----------------//
	//DRAW BEAST//
	//----------------//
	draw_sprite_ext(
		_stct_beast._spr_beast,
		0,
		_val_text_x + 170,
		_val_text_y + 350,
		0.25,
		0.25,
		0,
		c_white,
		1
	);

	//----------------//
	//SEEN DATA//
	//----------------//
	draw_set_colour(c_white);

	draw_text(
		_val_text_x,
		_val_text_y,
		"ARCHETYPE: " + string(_stct_beast._str_beast_archetype)
	);

	_val_text_y += _val_line_height;

	draw_text(
		_val_text_x,
		_val_text_y,
		"CLASS: " + string(_stct_beast._str_beast_class)
	);

	_val_text_y += _val_line_height;

	//================//
	//BEAST SUBTYPES//
	//================//
	draw_text(
		_val_text_x,
		_val_text_y,
		"TYPES: " + hscr_gui_logbook_array_to_text(
			_stct_beast._arr_beast_color_types,
			" / "
		)
	);

	_val_text_y += _val_line_height * 2;

	//----------------//
	//CAPTURE LOCK//
	//----------------//
	if (!_stct_entry._flag_captured){

		draw_set_colour(c_ltgray);

		draw_text_ext(
			_val_text_x,
			_val_text_y,
			"CAPTURE THIS BEAST TO REVEAL FULL STATS, ABILITIES, ROLE, AND LORE.",
			-1,
			_val_detail_w
		);

		return;
	}

	//----------------//
	//CAPTURED DATA//
	//----------------//
	draw_set_colour(c_white);

	draw_text(
		_val_text_x,
		_val_text_y,
		"HP: " +
		string(_stct_beast._val_beast_hp_stat) +
		" (" +
		scr_beast_get_grade_letter(_stct_beast._val_beast_hp_stat) +
		")"
	);

	_val_text_y += _val_line_height;

	draw_text(
		_val_text_x,
		_val_text_y,
		"PPOW: " +
		string(_stct_beast._val_beast_ppow_stat) +
		" (" +
		scr_beast_get_grade_letter(_stct_beast._val_beast_ppow_stat) +
		")"
	);

	_val_text_y += _val_line_height;

	draw_text(
		_val_text_x,
		_val_text_y,
		"MPOW: " +
		string(_stct_beast._val_beast_mpow_stat) +
		" (" +
		scr_beast_get_grade_letter(_stct_beast._val_beast_mpow_stat) +
		")"
	);

	_val_text_y += _val_line_height;

	draw_text(
		_val_text_x,
		_val_text_y,
		"PDEF: " +
		string(_stct_beast._val_beast_pdef_stat) +
		" (" +
		scr_beast_get_grade_letter(_stct_beast._val_beast_pdef_stat) +
		")"
	);

	_val_text_y += _val_line_height;

	draw_text(
		_val_text_x,
		_val_text_y,
		"MDEF: " +
		string(_stct_beast._val_beast_mdef_stat) +
		" (" +
		scr_beast_get_grade_letter(_stct_beast._val_beast_mdef_stat) +
		")"
	);

	_val_text_y += _val_line_height * 2;

	draw_text_ext(
		_val_text_x,
		_val_text_y,
		_stct_beast._str_beast_role,
		-1,
		_val_detail_w
	);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_DRAW_CARD_DETAILS
// FUNCTION: Draws the selected card logbook details.
//
// ARGUMENTS: _stct_entry is the selected card logbook entry.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_draw_card_details = function(_stct_entry){

	var _val_text_x = _val_detail_x;
	var _val_text_y = _val_start_y;
	var _val_line_height = 22;

	//----------------//
	//HEADER//
	//----------------//
	draw_set_colour(c_white);
	draw_set_font(fnt_gui_medium);
	draw_text(_val_text_x,_val_text_y,_stct_entry._str_card_name);

	draw_set_font(fnt_gui_small);
	_val_text_y += _val_line_height * 2;

	var _ct_owned = scr_logbook_get_card_owned_count(_stct_entry._str_card_id);

	draw_text(_val_text_x,_val_text_y,"COLOR: " + string(_stct_entry._str_color_group));
	_val_text_y += _val_line_height;

	draw_text(_val_text_x,_val_text_y,"SEEN: " + string(_stct_entry._flag_seen));
	_val_text_y += _val_line_height;

	draw_text(_val_text_x,_val_text_y,"OBTAINED: " + string(_stct_entry._flag_obtained));
	_val_text_y += _val_line_height;

	draw_text(_val_text_x,_val_text_y,"OWNED: " + string(_ct_owned));
	_val_text_y += _val_line_height * 2;

	//----------------//
	//NOT SEEN//
	//----------------//
	if (!_stct_entry._flag_seen){

		draw_set_colour(c_ltgray);

		draw_text_ext(
			_val_text_x,
			_val_text_y,
			"NO DATA. Find this card to reveal its information.",
			-1,
			_val_detail_w
		);

		return;
	}

	//----------------//
	//MISSING BASE DATA//
	//----------------//
	if (!_stct_entry._flag_has_card_info || _stct_entry._stct_card_info == undefined){

		draw_set_colour(c_ltgray);

		draw_text_ext(
			_val_text_x,
			_val_text_y,
			"BASE CARD DATA NOT IMPLEMENTED YET.",
			-1,
			_val_detail_w
		);

		return;
	}

	var _stct_card = _stct_entry._stct_card_info;

	//----------------//
	//DRAW CARD//
	//----------------//
	draw_sprite_ext(
		_stct_card._spr_card,
		0,
		_val_text_x + 170,
		_val_text_y + 350,
		0.45,
		0.45,
		0,
		c_white,
		1
	);

	//----------------//
	//CARD DATA//
	//----------------//
	draw_set_colour(c_white);

	draw_text(
		_val_text_x,
		_val_text_y,
		"TYPE: " + string(_stct_card._str_card_type)
	);

	_val_text_y += _val_line_height;

	draw_text(
		_val_text_x,
		_val_text_y,
		"RANGE: " + string(_stct_card._str_card_range)
	);

	_val_text_y += _val_line_height;

	draw_text(
		_val_text_x,
		_val_text_y,
		"RARITY: " + string(_stct_card._str_card_rarity)
	);

	_val_text_y += _val_line_height;

	draw_text(
		_val_text_x,
		_val_text_y,
		"MANA: " + string(_stct_card._val_card_mana_cost)
	);

	_val_text_y += _val_line_height * 2;

	draw_text_ext(
		_val_text_x,
		_val_text_y,
		_stct_card._str_card_description,
		-1,
		_val_detail_w
	);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_LOGBOOK_DRAW_SELECTED_DETAILS
// FUNCTION: Draws the selected Beast or card detail pane.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_logbook_draw_selected_details = function(){

	var _stct_entry = hscr_gui_logbook_get_selected_entry();

	if (_stct_entry == undefined){

		draw_set_colour(c_white);
		draw_text(_val_detail_x,_val_start_y,"NO ENTRY SELECTED");

		return;
	}

	if (_str_logbook_mode == "BEAST"){
		hscr_gui_logbook_draw_beast_details(_stct_entry);
	}
	else{
		hscr_gui_logbook_draw_card_details(_stct_entry);
	}
};

#endregion