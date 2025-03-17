//////////////////////////////////////////////////////////////////////
//					SCR_CREATE_STATUS_COUNTER						//
//																	//
// > CREATES A STATUS COUNTER TO KEEP TRACK OF A STATUS EFFECT ON	//
//   A UNIT															//	
//////////////////////////////////////////////////////////////////////
function scr_create_status_counter(_target, _name, _desc, _card, _trigger_period, _tick_script, _trigger_immediately, _check_script, _lifespan, _stacks, _magnitude, _charges, _type, _list, _sprite){
	var _ref_counter = instance_create_layer(room_width/2,room_height/2,"GUI",obj_card_status_counter);
	_ref_counter._counter_target = _target; //target unit (or "targetless" for utility) the counter is on
	_ref_counter._counter_tick_script = _tick_script; //used to apply an effect every time the counter triggers
	_ref_counter._counter_check_script = _check_script; //used to check if the conditions of this script have been met or not
	_ref_counter._counter_trigger_effect = _trigger_immediately; //flag to determine if the effect should trigger once
	_ref_counter._counter_name = _name; //NAME OF THE COUNTER (USED TO TRACK UTILITIES)
	_ref_counter._counter_desc = _desc; //for tooltip purposes
	_ref_counter._counter_type = _type; //General, Standalone (used in get status script)
	_ref_counter._counter_card = _card; //reference to card obj that cast it
	_ref_counter._counter_trigger_period = _trigger_period; //"Begin", "Reaction", "End", will determine what part of the turn it triggers on
	_ref_counter._counter_life = _lifespan; //when it reaches 0, undo its effects and blow up.
	_ref_counter._counter_stacks = _stacks; //used for some DoTs and HoTs
	_ref_counter._counter_magnitude = _magnitude; //explaination of dmg
	_ref_counter._counter_charges = _charges; //how many times can this counter trigger before blowing up?
	_ref_counter._counter_list = _list; //am I a reg counter or part of the global utilities list?
	if (_target != "Targetless"){
		_ref_counter._counter_team = _target._creature_team; //am I a reg counter or part of the global utilities list?
	}else {
		_ref_counter._counter_team = "Player"; //am I a reg counter or part of the global utilities list?
	}
		

	_ref_counter._counter_sprite = _sprite;
	_ref_counter.sprite_index = _sprite; //sprite to draw as
	////////////////////////
	// ADD TO TARGET LIST //
	////////////////////////
	ds_list_add(_list,_ref_counter);
}