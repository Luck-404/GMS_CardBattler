//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DISTRACTING_TRAP
// FUNCTION: Resolves Distracting Trap.
//           Places a hidden Trap on the selected Beast.
//
//===============================================================================//
function scr_card_viridian_distracting_trap(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_trap_init(
		"DISTRACTING_TRAP",
		_stct_card,
		_ref_caster,
		_ref_target
	);

	//-------------//
	//SPAWN POPUP//
	//-------------//
	if (instance_exists(_ref_caster)){

		if (_ref_caster._str_team == "PLAYER"){
			scr_gui_spawn_popup("TEXT","PLAYER HAS SET A TRAP",undefined,c_white,room_width/2,room_height/2 - 325);
		}
		else{
			scr_gui_spawn_popup("TEXT","ENEMY HAS SET A TRAP",undefined,c_white,room_width/2,room_height/2 - 325);
		}
	}

}