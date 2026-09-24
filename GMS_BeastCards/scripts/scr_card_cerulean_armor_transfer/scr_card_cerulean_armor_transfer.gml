//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ARMOR_TRANSFER
// FUNCTION: Transfers all existing caster Armor to a different allied Beast.
//           Bypasses Armor-gain modifiers, triggers and feedback.
//
// ARGUMENTS: _stct_card - Armor Transfer card struct (unused for quantity).
//            _ref_caster - source Beast; _ref_target - recipient Beast.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_armor_transfer(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE BEASTS//
	//================//
	if (!instance_exists(_ref_caster) || !instance_exists(_ref_target)){
		return;
	}

	if (_ref_caster == _ref_target){
		return;
	}

	//================//
	//GET CASTER ARMOR//
	//================//
	var _val_armor_transfer = max(0,_ref_caster._val_armor);

	if (_val_armor_transfer <= 0){
		return;
	}

	//================//
	//TRANSFER ARMOR//
	//================//
	scr_battle_transfer_armor(_ref_caster,_ref_target,_val_armor_transfer);
}
