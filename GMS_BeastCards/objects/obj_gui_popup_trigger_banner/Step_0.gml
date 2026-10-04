//===============================================================================//
//
// STEP: OBJ_GUI_POPUP_TRIGGER_BANNER
// FUNCTION: Updates the active trigger-banner stack and lifespan.
//           Older active banners remain lower in the stack.
//           Newer banners stack upward and collapse downward as older banners
//           expire.
//
//===============================================================================//

#region STACK POSITION

//================//
//RESET STACK SLOT//
//================//
_val_stack_index = 0;

//======================//
//COUNT OLDER BANNERS//
//======================//
var _ct_banners =
	instance_number(
		obj_gui_popup_trigger_banner
	);

for (
	var _it_banner = 0;
	_it_banner < _ct_banners;
	_it_banner++
){

	var _ref_banner =
		instance_find(
			obj_gui_popup_trigger_banner,
			_it_banner
		);

	if (!instance_exists(_ref_banner)){
		continue;
	}

	if (_ref_banner == id){
		continue;
	}

	if (
		_ref_banner._val_stack_order <
		_val_stack_order
	){
		_val_stack_index++;
	}
}

#endregion

#region LIFESPAN

//================//
//UPDATE LIFESPAN//
//================//
_ct_life--;

if (_ct_life <= 0){
	instance_destroy();
}

#endregion