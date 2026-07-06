//===============================================================================//
//
// CREATE: OBJ_MARKET_PRISM_INTERACTABLE
// FUNCTION: Initializes the prism market stall interaction state.
//           Stores the market type passed into the generic market pane.
//           Assigns a persistent market UID for prism purchase tracking.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = 1;

_flag_spawned = false;
_flag_triggered = false;
_ct_cooldown = 10;

_str_market_type = "PRISM";

if (!variable_instance_exists(id,"_str_market_uid")){
	_str_market_uid = "PRISM_MARKET_" + string(room) + "_" + string(x) + "_" + string(y);
}

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS
#endregion