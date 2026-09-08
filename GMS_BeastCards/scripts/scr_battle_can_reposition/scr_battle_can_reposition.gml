//===============================================================================//
//
// SCRIPT: scr_battle_can_reposition
// FUNCTION: Returns whether a Beast may currently be repositioned.
//
//===============================================================================//
function scr_battle_can_reposition(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	//----------------//
	//MUST BE ALIVE//
	//----------------//
	if (
		_ref_beast._str_list != "ALIVE" ||
		_ref_beast._val_cur_hp <= 0
	){
		return false;
	}

	//----------------------//
	//CHECK REPOSITION LOCK//
	//----------------------//
	if (scr_battle_has_reposition_lock(_ref_beast)){
		return false;
	}

	return true;
}