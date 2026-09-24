//===============================================================================//
//
// STEP: OBJ_BATTLE_WAIT
// FUNCTION: Counts down normal battle waits.
//           Supports optional completion callbacks for timed effect sequences.
//
//===============================================================================//

//================//
//COUNTDOWN//
//================//
if (_ct_life > 0){

	_ct_life--;

	//------------------//
	//CONTINUE WAITING//
	//------------------//
	if (_ct_life > 0){
		exit;
	}

	//---------------------------//
	//PRESERVE NORMAL WAIT TIMING//
	//---------------------------//
	if (!variable_instance_exists(id,"_scr_on_complete")){
		exit;
	}
}

//================//
//CHECK CALLBACK//
//================//
var _flag_keep_wait = false;

if (
	variable_instance_exists(id,"_scr_on_complete") &&
	_scr_on_complete != undefined
){

	//================//
	//EXECUTE CALLBACK//
	//================//
	_flag_keep_wait = _scr_on_complete(id);
}

//================//
//FINISH WAIT//
//================//
if (!_flag_keep_wait){
	instance_destroy();
}