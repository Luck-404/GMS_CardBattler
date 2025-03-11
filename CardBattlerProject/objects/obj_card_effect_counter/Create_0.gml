//////////////////////////////////////////////////////////////////////
//						SCR_CARD_BEASTIAL_BASH						//
//																	//
// > DEAL DAMAGE THREE UNITS, CENTER UNIT IS ALSO STUNS FOR 1 TURN  //	
//////////////////////////////////////////////////////////////////////
_turn_lifespan = undefined; //set this when spawned
_reference_script = undefined; //set this when spawned
_target = undefined; //target for the effect to keep triggering on once a turn
_trigger_my_effect = false; //trigger effect once when spawned
_draw_color = undefined; //COLOR TO DRAW COUNTER LIFETIME AS
_counter_name = undefined; //NAME OF THE COUNTER (USED TO TRACK UTILITIES)
_counter_team = undefined; //WHO OWNS THE COUNTER?
_trigger_time = "End"; //"Begin" or "End"
_checker_script = undefined;