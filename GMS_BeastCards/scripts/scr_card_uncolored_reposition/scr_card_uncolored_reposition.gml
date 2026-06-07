//
//
// SCRIPT: SCR_CARD_UNCOLORED_STRIKE | Melee, ST, Deals [linear] melee damage | RETURNS VOID
//
//
function scr_card_uncolored_reposition(_card,_caster,_target){
	var _stored_x = _caster.x;
	_caster.x = _target.x;
	_target.x = _stored_x;
	
	var _stored_caster_pos = ds_list_find_index(obj_battle_player_controller._beasts_alive,_caster);
	var _stored_tar_pos = ds_list_find_index(obj_battle_player_controller._beasts_alive,_target);
	
	ds_list_set(obj_battle_player_controller._beasts_alive,_stored_caster_pos,_target);
	ds_list_set(obj_battle_player_controller._beasts_alive,_stored_tar_pos,_caster);
	
	_target._pos = _stored_caster_pos;
	_caster._pos = _stored_tar_pos;
	
	scr_check_unit_pos(_target);
	scr_check_status_pos(_target);		
	scr_check_unit_pos(_caster);	
	scr_check_status_pos(_caster);		
	//PLAY ANIMATION
	
	//PLAY SOUND
	
	//POPUP
	scr_spawn_scrolling_popup("TEXT","SWAPPED PLACES",undefined,c_black,_caster.x+irandom_range(-32,32),_caster.y-24+irandom_range(-32,32));		
	scr_spawn_scrolling_popup("TEXT","SWAPPED PLACES",undefined,c_black,_target.x+irandom_range(-32,32),_target.y-24+irandom_range(-32,32));

}