//===============================================================================//
//
// SCRIPT: SCR_GET_CC_LIFETIME
// FUNCTION: Returns final CC lifetime.
//           Adds caster CC-duration bonuses only during direct card resolution.
//
//===============================================================================//

function scr_get_cc_lifetime(_val_lifetime,_val_default_lifetime){

	if (_val_lifetime == undefined){
		_val_lifetime = _val_default_lifetime;
	}

	var _val_bonus = 0;

	if (
		global.flag_card_effect_resolving &&
		instance_exists(global.ref_caster_beast)
	){

		_val_bonus =
			max(
				0,
				global.ref_caster_beast._val_cc_duration_bonus
			);
	}

	return max(
		1,
		_val_lifetime + _val_bonus
	);
}