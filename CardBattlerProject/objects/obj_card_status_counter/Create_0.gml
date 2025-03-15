//////////////////////////////////////////////////////////////////////
//					OBJ_CARD_EFFECT_COUNTER							//
//																	//
// > ESTABLSH VARIABLES FOR EFFECT COUNTERS						    //	
//////////////////////////////////////////////////////////////////////
_counter_target = undefined; //target unit (or "targetless" for utility) the counter is on
_counter_tick_script = undefined; //used to apply an effect every time the counter triggers
_counter_check_script = undefined; //used to check if the conditions of this script have been met or not
_counter_trigger_effect = false; //flag to determine if the effect should trigger once
_counter_name = undefined; //NAME OF THE COUNTER (USED TO TRACK UTILITIES)
_counter_desc = ""; //for tooltip purposes
_counter_type = ""; //General or Standalone
_counter_card = undefined; //reference to card obj that cast it
_counter_trigger_period = "End"; //"Begin", "Reaction", "End", will determine what part of the turn it triggers on
_counter_life = 999; //when it reaches 0, undo its effects and blow up.
_counter_stacks = 1; //used for some DoTs and HoTs
_counter_magnitude = ""; //used for some DoTs and HoTs
_counter_charges = 1; //how many times can this counter trigger before blowing up?
_counter_list = undefined; //am I a reg counter or part of the global utilities list?
_counter_sprite = undefined;
_counter_index = 0;

_counter_delete_flag = false;