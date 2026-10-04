//===============================================================================//
//
// BEGIN STEP: OBJ_GUI_CONTROLLER
// FUNCTION: Clears frame-local hover and Ctrl-inspection GUI requests.
//
//===============================================================================//

#region HOVER TOOLTIP

global.flag_gui_hover_tooltip =
	false;

global.str_gui_hover_tooltip_title =
	"";

global.str_gui_hover_tooltip_body =
	"";

global.val_gui_hover_tooltip_priority =
	-100000;

#endregion

#region BATTLE INSPECTION

global.flag_battle_inspection =
	false;

global.str_battle_inspection_title =
	"";

global.str_battle_inspection_body =
	"";

global.val_battle_inspection_priority =
	-100000;

#endregion