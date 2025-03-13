//////////////////////////////////////////////////////////////////////
//							SCR_CARD_FELL							//
//																	//
// > DEAL DAMAGE TO ONE UNIT AT MELEE								//	
//////////////////////////////////////////////////////////////////////
function scr_card_fell(_card,_channel,_target){
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _base_dmg_percent = _card[?"damage"]
	var _base_dmg = ceil((_base_dmg_percent/100)*_target._creature_hp_max);
	var _color_mult = scr_calculate_color_damage_bonus(_card[?"color"],_target);
	var _scalar = _channel._creature_attack_scalar;
	var _linear = _channel._creature_attack_linear; 
	
	// Calculate final damage percentage
	var _scaled_dmg = _base_dmg * _scalar * _color_mult; 
	var _final_dmg = _scaled_dmg + _linear;

	////////////
	// DAMAGE //
	////////////
	scr_damage_creature(_target, _final_dmg);
		show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card[?"name"] + " damage dealt = " + string(_final_dmg) + " to " + _target._creature_name);
	scr_trigger_minion_reactions(_card,_target,_channel,_final_dmg);
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_fell;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_fell,0,false);			
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _target._creature_name + " for " + string(_final_dmg);
}