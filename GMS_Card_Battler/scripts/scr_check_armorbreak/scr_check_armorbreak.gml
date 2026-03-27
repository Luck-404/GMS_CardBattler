//////////////////////////////////////////////////////////////////////
//					SCR_CHECK_ARMORBREAK							//
//																	//
// > CHECKS IF THE TARGET IS ARMORBROKEN							//
//////////////////////////////////////////////////////////////////////
function scr_check_armorbreak(_target){
	if (_target._status_armorbreak == true){
		scr_create_combat_popup(_target,"Shield apply failed: armorbroken","Default",0,0);
		return true;
	}
	return false;
}