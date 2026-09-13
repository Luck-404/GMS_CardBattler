//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_BASTION
// FUNCTION: Resolves Frozen Bastion.
//           Doubles the caster's current Armor.
//
// ARGUMENTS: _stct_card is the Frozen Bastion card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_frozen_bastion(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//=================//
	//GET CURRENT ARMOR//
	//=================//
	var _val_armor_gain = max(0,_ref_caster._val_armor);

	if (_val_armor_gain <= 0){
		return;
	}

	//================//
	//DOUBLE ARMOR//
	//================//
	scr_battle_armor_target(
		_val_armor_gain,
		_ref_caster
	);
}