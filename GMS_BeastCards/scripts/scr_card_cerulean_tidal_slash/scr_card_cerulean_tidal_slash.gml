//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDAL_SLASH
// FUNCTION: Resolves Tidal Slash.
//           Deals linear physical damage to the selected target.
//           Deals 5 additional damage while Rain Weather is active.
//
// ARGUMENTS: _stct_card is the Tidal Slash card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_tidal_slash(_stct_card,_ref_caster,_ref_target){

	//================//
	//CALCULATE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;
	var _ref_rain = scr_status_check("WEATHER: RAIN",global.list_statuses);

	if (_ref_rain != -1){
		_val_damage += 5;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_val_damage,
		_ref_target
	);
}