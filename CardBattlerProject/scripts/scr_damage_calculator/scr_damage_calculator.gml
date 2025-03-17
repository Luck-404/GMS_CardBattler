//////////////////////////////////////////////////////////////////////
//						SCR_DAMAGE_CALCULATOR						//
//																	//
// > CALCULATE DAMAGE FROM PLAYING A CARD							//	
//////////////////////////////////////////////////////////////////////
function scr_damage_calculator(_card,_channel,_target,_percent,_damage){
	var _base_dmg = 0;
	if (_percent != 0){
		_base_dmg = ceil((_percent/100)*_target._creature_hp_max);
	} else {
		if (_damage == 0){
			_base_dmg = _card._card_ref[?"damage"]; //base damage from card
		}
		else{
			_base_dmg = _damage;	
		}
	}
	
	/////////////////
	// COLOR BONUS //
	/////////////////
	var _color_mult = scr_calculate_color_damage_bonus(_card._card_color,_target); //calculate the damage from card vs target (0.5x or 2.0x)
	var _post_color_dmg = _base_dmg*_color_mult;
	
	////////////////
	// SCALED DMG //
	////////////////
	var _scalar = _channel._creature_attack_scalar; //get creature attack scalar
	var _scaled_dmg = _post_color_dmg*_scalar;
	
	///////////////////
	// VULNERABILITY //
	///////////////////
	var _vuln_dmg = _scaled_dmg*(1+(0.5*_target._creature_vulnerability_scalar_stacks));
	
	///////////////
	// FINAL DMG //
	///////////////	
	var _final_dmg = _vuln_dmg + _channel._creature_attack_linear;
	
	return _final_dmg;
}