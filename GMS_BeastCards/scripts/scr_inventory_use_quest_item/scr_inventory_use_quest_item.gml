//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_QUEST_ITEM
// FUNCTION: Uses a quest item from the overworld inventory.
//           Runs the quest item's attached script when available.
//           Opens fallback text when no quest script is assigned.
//
//===============================================================================//
function scr_inventory_use_quest_item(_stct_item,_ref_inventory_pane){

	if (_stct_item == undefined){
		scr_inventory_cancel_item_use(_ref_inventory_pane);
		return false;
	}

	if (_stct_item._scr_item == undefined){

		var _ref_textbox = instance_create_layer(
			display_get_gui_width() * 0.5,
			display_get_gui_height() * 0.5,
			"ily_fx",
			obj_gui_scrolling_textbox
		);

		audio_play_sound(snd_use_item,0,false);

		_ref_textbox._ref_parent_gui = _ref_inventory_pane;
		_ref_textbox._str_text = "Nothing seems to happen.";

		return false;
	}

	return _stct_item._scr_item(_stct_item,_ref_inventory_pane);
}