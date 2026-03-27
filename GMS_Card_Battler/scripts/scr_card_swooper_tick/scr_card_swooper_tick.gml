//////////////////////////////////////////////////////////////////////
//					SCR_CARD_POTENT_FRUIT_TICK						//
//																	//
// > UNDO BUFF AFTER TIMER ELAPSED									//	
//////////////////////////////////////////////////////////////////////
function scr_card_swooper_tick(_counter,_target,_repeat){		//STACKLESS		//DEFAULT LIFETIME: 3

	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		/////////////////
		// LEFT TARGET //
		/////////////////
		if (_target._left_unit != undefined){
			var _left_target = _target._left_unit;
			////////////////
			// VULNERABLE //
			////////////////
			var _status_counter = scr_get_status_counter(_left_target, "General", undefined, "Vulnerablility Scalar");		
			if (_status_counter == undefined){		
				scr_create_status_counter(_left_target,"Vulnerablility Scalar","Increase damage taken by this unit by 50% per stack.","Reaction","End",scr_status_vulnerable_scalar_tick, true, undefined, 1, 1, "+50% damage taken per stack", 0, "General", _left_target._creature_statuses, spr_status_vulnerability_up_scalar);
				_left_target._creature_vulnerability_scalar_stacks+=1;
				scr_create_combat_popup(_left_target,"Vulnerable applied","Default",0,0);		
				scr_create_combat_effect(_left_target,spr_effect_powerdown,0,0,36,c_purple,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");		
				audio_play_sound(snd_effect_debuff,0,false);	
			} 
			else {
				scr_create_combat_popup(_left_target,"+50% vulnerable","Default",0,0);			
				_status_counter._counter_life = 1;
				_status_counter._counter_stacks +=1;
				_left_target._creature_vulnerability_scalar_stacks+=1;
			}	
		}
		
		//////////////////
		// RIGHT TARGET //
		//////////////////
		if (_target._right_unit != undefined){
			var _right_target = _target._right_unit;
			////////////////
			// VULNERABLE //
			////////////////
			var _status_counter = scr_get_status_counter(_right_target, "General", undefined, "Vulnerablility Scalar");		
			if (_status_counter == undefined){		
				scr_create_status_counter(_right_target,"Vulnerablility Scalar","Increase damage taken by this unit by 50% per stack.","Reaction","End",scr_status_vulnerable_scalar_tick, true, undefined, 1, 1, "+50% damage taken per stack", 0, "General", _right_target._creature_statuses, spr_status_vulnerability_up_scalar);
				_right_target._creature_vulnerability_scalar_stacks+=1;
				scr_create_combat_popup(_right_target,"Vulnerable applied","Default",0,0);		
				scr_create_combat_effect(_right_target,spr_effect_powerdown,0,0,36,c_purple,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");		
				audio_play_sound(snd_effect_debuff,0,false);	
			} 
			else {
				scr_create_combat_popup(_right_target,"+50% vulnerable","Default",0,0);			
				_status_counter._counter_life = 1;
				_status_counter._counter_stacks +=1;
				_right_target._creature_vulnerability_scalar_stacks+=1;
			}	
		}
	
		///////////////////
		// MIDDLE TARGET //
		///////////////////
		#region MIDDLE TARGET
		////////////
		// DAMAGE //
		////////////
		scr_damage_creature(_target, 5);
		
		////////////
		// EFFECT //
		////////////
		scr_create_combat_effect(_target,spr_effect_slice,0,0,5,c_white,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
		scr_create_combat_effect(_target,spr_effect_swooper,0,0,21,c_white,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
		audio_play_sound(snd_effect_screech,0,false);	
	
		////////////////
		// VULNERABLE //
		////////////////
			var _status_counter = scr_get_status_counter(_target, "General", undefined, "Vulnerablility Scalar");		
			if (_status_counter == undefined){		
				scr_create_status_counter(_target,"Vulnerablility Scalar","Increase damage taken by this unit by 50% per stack.","Reaction","End",scr_status_vulnerable_scalar_tick, true, undefined, 1, 1, "+50% damage taken per stack", 0, "General", _target._creature_statuses, spr_status_vulnerability_up_scalar);
				_target._creature_vulnerability_scalar_stacks+=1;
				scr_create_combat_popup(_target,"Vulnerable applied","Default",0,0);		
				scr_create_combat_effect(_target,spr_effect_powerdown,0,0,36,c_purple,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");		
				audio_play_sound(snd_effect_debuff,0,false);	
			} 
			else {
				scr_create_combat_popup(_target,"+50% vulnerable","Default",0,0);			
				_status_counter._counter_life = 1;
				_status_counter._counter_stacks +=1;
				_target._creature_vulnerability_scalar_stacks+=1;	
			}
	#endregion
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		scr_create_combat_popup(_target,"Swooper wore off","Default",0,0);
		_counter._counter_delete_flag = true;		
	} 
}