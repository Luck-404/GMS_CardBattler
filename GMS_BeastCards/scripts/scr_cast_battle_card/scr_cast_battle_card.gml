//
//
//
//
//
function scr_cast_battle_card(){

var _card = global.cast_card;
var _card_ref = _card._ref_card;
var _caster = global.caster_beast;
var _tar = global.target_beast;

var _scr = _card_ref[?"card_script"];
var _cost = _card_ref[?"card_mana_cost"];

//PLAY CARD EFFECT
if (global.caster_beast._team == "PLAYER" && global.echo_counter != 0 && _card_ref[?"card_name"] != "ECHO"){
	for (var _i = 0; _i < global.echo_counter+1; _i++){
		_scr(_card_ref,_caster,_tar);
	}
	global.echo_counter = 0;
} else {
	_scr(_card_ref,_caster,_tar);
}

//DEDUCT MANA FOR CARD CAST
if (global.caster_beast._team == "PLAYER"){
obj_battle_player_controller._cur_mana -= _cost;
}

//(FUTURE) TRIGGER EFFECTS

//EXHAUST
if (global.caster_beast._team == "PLAYER"){
	if (_card_ref[?"card_exhausts"] == true){
		scr_exhaust_battle_card(_card);
	} else {
	//DISCARD 
		scr_discard_battle_card(_card);
	}
}

//RESET AT END
global.cast_card = undefined;
global.caster_beast = undefined;
global.target_beast = undefined;
}