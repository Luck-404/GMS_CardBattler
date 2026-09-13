//===============================================================================//
//
// SCRIPT: SCR_CC_GET_LIFETIME
// FUNCTION: Returns the final Crowd Control lifetime.
//           Uses the supplied default when no lifetime is provided.
//           Adds caster CC-duration bonuses only during direct card resolution.
//
//===============================================================================//

function scr_cc_get_lifetime(_val_lifetime,_val_default_lifetime){

	//------------------//
	//DEFAULT LIFETIME//
	//------------------//
	if (_val_lifetime == undefined){
		_val_lifetime = _val_default_lifetime;
	}

	var _val_bonus = 0;

	//===================//
	//CC DURATION BONUS//
	//===================//
	if (
		global.flag_card_effect_resolving &&
		instance_exists(global.ref_caster_beast)
	){

		_val_bonus = max(0,global.ref_caster_beast._val_cc_duration_bonus);
	}

	//================//
	//FINAL LIFETIME//
	//================//
	return max(1,_val_lifetime + _val_bonus);
}