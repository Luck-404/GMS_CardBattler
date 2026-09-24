//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_QUEST_IMPORTANT_NOTEBOOK
// FUNCTION: Handles the Important Notebook quest item.
//           Checks quest-use criteria before resolving item behavior.
//           Awards hidden cards and displays the resulting feedback.
//
// ARGUMENTS: _stct_item is the quest item struct.
//            _ref_inventory_pane is the owning inventory pane.
// RETURNS: True when the quest item successfully resolves, otherwise false.
//
//===============================================================================//

function scr_inventory_item_quest_important_notebook(_stct_item,_ref_inventory_pane){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		scr_inventory_cancel_item_use(_ref_inventory_pane);
		return false;
	}

	var _flag_success = false;
	var _str_text = "";

	//================//
	//CHECK CRITERIA//
	//================//
	if (room == rm_ow_west){
		_flag_success = true;
	}

	//================//
	//SUCCESS//
	//================//
	if (_flag_success){

		audio_play_sound(snd_overworld_treasure_claim,0,false);

		var _arr_card_ids = [
			"ECHO",
			"EMERALD_WISDOM",
			"HIDDEN_CARD"
		];

		var _flag_added_to_deck = false;
		var _flag_added_to_library = false;

		//----------------//
		//AWARD CARDS//
		//----------------//
		for (var _it_card = 0; _it_card < array_length(_arr_card_ids); _it_card++){

			var _str_card_id = _arr_card_ids[_it_card];

			var _ct_deck_before = ds_list_size(global.list_player_deck);
			var _ct_library_before = ds_list_size(global.list_player_library);

			var _stct_new_card = scr_card_get_info(_str_card_id);

			scr_deck_add_card(_stct_new_card);

			var _ct_deck_after = ds_list_size(global.list_player_deck);
			var _ct_library_after = ds_list_size(global.list_player_library);

			if (_ct_deck_after > _ct_deck_before){
				_flag_added_to_deck = true;
			}

			if (_ct_library_after > _ct_library_before){
				_flag_added_to_library = true;
			}
		}

		//----------------//
		//CONSUME NOTEBOOK//
		//----------------//
		scr_inventory_remove_item(_stct_item,1);

		if (instance_exists(_ref_inventory_pane)){
			_ref_inventory_pane.hscr_gui_inventory_mark_dirty();
		}

		//----------------//
		//BUILD RESULT TEXT//
		//----------------//
		var _str_destination = "deck";

		if (_flag_added_to_deck && _flag_added_to_library){
			_str_destination = "deck and library";
		}
		else if (_flag_added_to_library){
			_str_destination = "library";
		}

		_str_text =
			"You have found some hidden cards in the tome!" +
			"\n\nAdded ECHO, EMERALD WISDOM, and HIDDEN CARD to your " +
			_str_destination +
			".";
	}

	//================//
	//FAILURE//
	//================//
	else{
		audio_play_sound(snd_gui_error,0,false);
		_str_text = "Nothing seems to happen.";
	}

	//================//
	//OPEN TEXTBOX//
	//================//
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