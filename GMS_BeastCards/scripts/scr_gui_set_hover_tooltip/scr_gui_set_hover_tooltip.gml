//===============================================================================//
//
// SCRIPT: SCR_GUI_SET_HOVER_TOOLTIP
// FUNCTION: Registers one GUI hover tooltip for the current frame.
//           Higher-priority requests replace lower-priority requests.
//
// ARGUMENTS:
//     _str_title    - Tooltip title.
//     _str_body     - Optional tooltip body.
//     _val_priority - Overlap priority.
//
// RETURNS: True when this request becomes the active tooltip.
//
//===============================================================================//

function scr_gui_set_hover_tooltip(
	_str_title,
	_str_body="",
	_val_priority=0
){

	//================//
	//VALIDATE TITLE//
	//================//
	if (_str_title == undefined){
		return false;
	}

	_str_title =
		string(_str_title);

	if (_str_title == ""){
		return false;
	}

	//================//
	//ENSURE GLOBALS//
	//================//
	if (!variable_global_exists("flag_gui_hover_tooltip")){

		global.flag_gui_hover_tooltip = false;

		global.str_gui_hover_tooltip_title = "";
		global.str_gui_hover_tooltip_body = "";

		global.val_gui_hover_tooltip_priority = -100000;
	}

	//================//
	//CHECK PRIORITY//
	//================//
	if (
		global.flag_gui_hover_tooltip &&
		_val_priority <
		global.val_gui_hover_tooltip_priority
	){
		return false;
	}

	//================//
	//STORE TOOLTIP//
	//================//
	global.flag_gui_hover_tooltip = true;

	global.str_gui_hover_tooltip_title =
		string_upper(
			string_replace_all(
				_str_title,
				"_",
				" "
			)
		);

	global.str_gui_hover_tooltip_body =
		string(_str_body);

	global.val_gui_hover_tooltip_priority =
		_val_priority;

	return true;
}