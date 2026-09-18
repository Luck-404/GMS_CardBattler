//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_VOLATILE_BRAND
// FUNCTION: Resolves Volatile Brand.
//           Sets a Death Trap on the selected enemy Beast.
//
// ARGUMENTS: _stct_card is the Volatile Brand Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected enemy Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_volatile_brand(_stct_card,_ref_caster,_ref_target){

	//==================//
	//SET VOLATILE BRAND//
	//==================//
	scr_trap_init(
		"VOLATILE_BRAND",
		_stct_card,
		_ref_caster,
		_ref_target
	);
}