//===============================================================================//
//
// CLEAN UP: OBJ_GUI_INVENTORY_PANE
// FUNCTION: Destroys the cached filtered inventory list.
//           Prevents DS list memory leaks when the inventory pane closes.
//
//===============================================================================//

//================//
//DESTROY CACHE//
//================//
if (ds_exists(_list_filtered_inventory,ds_type_list)){
	ds_list_destroy(_list_filtered_inventory);
}