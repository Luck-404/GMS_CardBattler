//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_PRISM_ITEM_OW
// FUNCTION: Handles prism use from the overworld inventory.
//           Opens a click-controlled scrolling textbox.
//           Does not consume the prism or mutate inventory.
//
//===============================================================================//
function scr_inventory_use_prism_item_ow(_stct_item,_ref_inventory_pane){

	var _ref_textbox = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_scrolling_textbox
	);
	
	audio_play_sound(snd_use_item,0,false);

	_ref_textbox._ref_parent_gui = _ref_inventory_pane;
	_ref_textbox._str_text = string(_stct_item._str_item_desc) + "\n\nThis item does nothing outside of battle...";
}