//////////////////////////////////////////////////////////////////////
//					OBJ_CARD_EFFECT_COUNTER TICK					//
//																	//
// > EVERY TURN DECREMENT LIFESPAN AND TRIGGER EFFECT ONCE			//	
//////////////////////////////////////////////////////////////////////

///////////
// DEATH //
///////////
if (_turn_lifespan <= 0){
	_reference_script(_target,false); //TRIGGER REFERENCE TO CLEANUP EFFECT
	instance_destroy(); //DESTROY SELF
}
if (_target != "Targetless"){
	if(_target._creature_hp_current <= 0){
		instance_destroy(); //DESTROY SELF
	}
}

/////////////////////////
// TRIGGER EFFECT ONCE //
/////////////////////////
if (_reference_script != undefined && _trigger_my_effect == true){
	_reference_script(_target,true);
	_trigger_my_effect = false;
}

///////////////////////////
// DRAW COUNTER LIFETIME //
///////////////////////////
draw_set_color(_draw_color);
draw_set_font(fnt_fanwood_sm);
if (_target == "Targetless"){
	draw_text(x,y,string(_turn_lifespan));
} else{
	if (_turn_lifespan > 10){
		
	} else {
		draw_text(_target.x,_target.y-145,string(_turn_lifespan));
	}	
}
draw_set_color(c_white);