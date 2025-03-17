//////////////////////////////////////////////////////////////////////
//						scr_card_swooper							//
//																	//
// > dmg and vuln targets											//	
//////////////////////////////////////////////////////////////////////
function scr_card_swooper(_card,_channel,_target){
	///////////////////
	// SWOOPER APPLY //
	///////////////////
	var _counter = scr_get_status_counter(_target, "Standalone", _card._card_name, undefined);		
	if (_counter == undefined){		
		scr_create_status_counter(_target,"Swooper","Swoops at a target dealing 5 damage, lasts 3 turns. Terrorizes 3 targets, making them vulnerable.",_card,"End",scr_card_swooper_tick, true, undefined, 3, 0, "5 damage", 0, "Standalone", _target._creature_statuses, spr_status_swoop_owl);
		scr_create_combat_popup(_target,"Swooping for 3 turns","Default",0,0);	
	} 
	else {
		_counter._counter_life = 3;
	}	
	scr_trigger_global_reactions(_card,_target,_channel,0);
		
		
		
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_name + " on " + _target._creature_name);		
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}