//===============================================================================//
//
// SCRIPT: SCR_ITEM_QUEST_IMPORTANT_NOTEBOOK
// FUNCTION: Handles the Important Notebook quest item.
//           Checks quest-use criteria before resolving item behavior.
//           Displays success or failure text through the scrolling textbox.
//
//===============================================================================//
function scr_item_quest_important_notebook(_stct_item,_ref_inventory_pane){

	var _flag_success = false;
	var _str_text = "";

	//----------//
	//CRITERIA//
	//----------//
	if (room == rm_ow_west){
		_flag_success = true;
	}

	//--------//
	//SUCCESS//
	//--------//
	if (_flag_success){

		var _arr_card_ids = [
			"ECHO",
			"EMERALD_WISDOM",
			"HIDDEN_CARD"
		];

		var _str_destination = "deck";

		for (var _it_card = 0; _it_card < array_length(_arr_card_ids); _it_card++){

			var _str_card_id = _arr_card_ids[_it_card];

			var _ct_deck_before = ds_list_size(global.list_player_deck);
			var _ct_library_before = ds_list_size(global.list_player_library);

			var _stct_new_card = scr_get_card_info(_str_card_id);

			scr_add_card_to_deck(_stct_new_card);

			var _ct_deck_after = ds_list_size(global.list_player_deck);
			var _ct_library_after = ds_list_size(global.list_player_library);

			if (_ct_deck_after > _ct_deck_before){
				_str_destination = "deck";
			}
			else if (_ct_library_after > _ct_library_before){
				_str_destination = "library";
			}
		}

		//----------------//
		//CONSUME NOTEBOOK//
		//----------------//
		scr_remove_item_from_inventory(_stct_item,1);

		if (instance_exists(_ref_inventory_pane)){
			_ref_inventory_pane.hscr_mark_inventory_dirty();
		}

		_str_text =
			"You have found some hidden cards in the tome!" +
			"\n\nAdded ECHO, EMERALD WISDOM, and HIDDEN CARD to your " + _str_destination + ".";
	}

	//--------//
	//FAILURE//
	//--------//
	else{
		_str_text = "Nothing seems to happen.";
	}

	//-------//
	//TEXTBOX//
	//-------//
	var _ref_textbox = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_scrolling_textbox
	);

	_ref_textbox._ref_parent_gui = _ref_inventory_pane;
	_ref_textbox._str_text = _str_text;

	return _flag_success;
}