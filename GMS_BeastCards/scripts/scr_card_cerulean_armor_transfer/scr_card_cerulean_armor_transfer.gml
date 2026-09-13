//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ARMOR_TRANSFER
// FUNCTION: Resolves Armor Transfer.
//           Transfers all current Armor from the caster to the selected
//           allied Beast.
//
// ARGUMENTS: _stct_card is the Armor Transfer card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
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
	_ref_caster._val_armor = 0;
	_ref_target._val_armor += _val_armor_transfer;
}