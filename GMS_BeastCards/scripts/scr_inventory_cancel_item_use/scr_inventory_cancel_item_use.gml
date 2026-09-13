//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_CANCEL_ITEM_USE
// FUNCTION: Cancels inventory item use.
//           Reactivates the inventory pane after a prompt is dismissed.
//           Starts a short input lockout to prevent click-through.
//
// ARGUMENTS: _ref_inventory_pane is the owning inventory pane.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_inventory_cancel_item_use(_ref_inventory_pane){

	//================//
	//RESTORE INVENTORY//
	//================//
	if (instance_exists(_ref_inventory_pane)){
		_ref_inventory_pane._flag_prompt_active = false;
		_ref_inventory_pane.hscr_gui_inventory_start_input_lockout();
	}
}