//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_REPOSITION
// FUNCTION: Resolves the Reposition card effect.
//           Swaps the positions of the caster and target.
//           Repositions attached minions and statuses.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_reposition(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//SWAP POSITIONS//
	//----------------//
	var _val_temp_x = _ref_caster.x;
	_ref_caster.x = _ref_target.x;
	_ref_target.x = _val_temp_x;

	var _val_caster_pos = ds_list_find_index(obj_battle_player_controller._list_beasts_alive,_ref_caster);
	var _val_target_pos = ds_list_find_index(obj_battle_player_controller._list_beasts_alive,_ref_target);

	ds_list_set(obj_battle_player_controller._list_beasts_alive,_val_caster_pos,_ref_target);
	ds_list_set(obj_battle_player_controller._list_beasts_alive,_val_target_pos,_ref_caster);

	_ref_target._pos = _val_caster_pos;
	_ref_caster._pos = _val_target_pos;

	scr_reposition_minions(_ref_target);
	scr_reposition_statuses(_ref_target);
	scr_reposition_minions(_ref_caster);
	scr_reposition_statuses(_ref_caster);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_beast_summon,0,false);

	//-------------//
	//SPAWN POPUPS//
	//-------------//
	scr_spawn_popup_scrolling("TEXT","SWAPPED PLACES",undefined,c_black,_ref_caster.x + irandom_range(-32,32),_ref_caster.y - 24 + irandom_range(-32,32));
	scr_spawn_popup_scrolling("TEXT","SWAPPED PLACES",undefined,c_black,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));
}