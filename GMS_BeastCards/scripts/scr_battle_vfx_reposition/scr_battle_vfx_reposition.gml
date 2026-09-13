//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_REPOSITION
// FUNCTION: Smoothly animates a battle Beast from its previous X position
//           to its newly assigned battlefield position.
//           Does not alter logical formation position or team order.
//
// INPUTS:   _ref_beast   - Battle Beast being visually repositioned.
//           _val_old_x   - Beast X position before the formation change.
//           _ct_duration - Reposition animation duration in frames.
//
//===============================================================================//

function scr_battle_vfx_reposition(_ref_beast,_val_old_x,_ct_duration=8){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	//-----------------------//
	//CALCULATE START OFFSET//
	//-----------------------//
	var _val_start_offset_x =
		_val_old_x -
		_ref_beast.x;

	//----------------//
	//START MOVEMENT//
	//----------------//
	_ref_beast._str_vfx_motion = "REPOSITION";

	_ref_beast._ct_vfx_motion_duration = max(2,_ct_duration);
	_ref_beast._ct_vfx_motion = _ref_beast._ct_vfx_motion_duration;

	_ref_beast._val_vfx_motion_start_x = _val_start_offset_x;

	_ref_beast._val_vfx_offset_x = _val_start_offset_x;
	_ref_beast._val_vfx_offset_y = 0;

	return true;
}