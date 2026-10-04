//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_MATERIAL_ITEM
// FUNCTION: Handles direct overworld use of a Material.
//           Materials cannot be consumed directly from the Inventory.
//           Displays informational feedback without changing the item stack.
//
// ARGUMENTS: _stct_item - Selected Material item struct.
//            _ref_inventory_pane - Inventory pane that initiated the use.
// RETURNS: True when informational feedback is opened; otherwise false.
//
//===============================================================================//

function scr_inventory_use_material_item(_stct_item,_ref_inventory_pane){

	#region VALIDATION

	//================//
	//VALIDATE ITEM//
	//================//
	if (!is_struct(_stct_item)){

		scr_inventory_cancel_item_use(_ref_inventory_pane);

		return false;
	}

	#endregion

	#region FEEDBACK

	//================//
	//CREATE TEXTBOX//
	//================//
	var _ref_textbox = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_scrolling_textbox
	);

	if (!instance_exists(_ref_textbox)){

		scr_inventory_cancel_item_use(_ref_inventory_pane);

		return false;
	}

	//================//
	//SET TEXTBOX DATA//
	//================//
	_ref_textbox._ref_parent_gui = _ref_inventory_pane;

	_ref_textbox._str_text =
		string(_stct_item._str_item_desc) +
		"\n\nThis material cannot be used directly.";

	//================//
	//SOUND//
	//================//
	audio_play_sound(
		snd_inventory_use_item,
		0,
		false
	);

	#endregion

	return true;
}